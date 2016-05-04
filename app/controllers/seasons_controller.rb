class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :edit, :update, :destroy]
  before_action :redirect_non_user
  before_action :redirect_non_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # GET /seasons
  # GET /seasons.json
  def index
    @seasons = Season.where(league_id: params[:league_id])
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def show
    @teams = @season.teams
  end

  # GET /seasons/new
  def new
    @season = Season.new
  end

  # GET /seasons/1/edit
  def edit
  end

  # POST /seasons
  # POST /seasons.json
  def create
    @season = Season.new(season_params)
    @season.league_id = params[:league_id]
    
    if Season.where(league_id: params[:league_id], name: season_params[:name]).first
      @errors = ['A season with that name already exists for the league']
      render :new
    else
      respond_to do |format|
        if @season.save
          format.html { redirect_to show_season_path(@season), notice: 'Season was successfully created.' }
          format.json { render :show, status: :created, location: @season }
        else
          format.html { render :new }
          format.json { render json: @season.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /seasons/1
  # PATCH/PUT /seasons/1.json
  def update
    if Season.where(league_id: @season.league_id, name: season_params[:name]).first && @season.name != season_params[:name]
      @errors = ['A season with that name already exists for the league']
      render :edit
    else
      respond_to do |format|
        if @season.update(season_params)
          format.html { redirect_to show_season_path(@season), notice: 'Season was successfully updated.' }
          format.json { render :show, status: :ok, location: @season }
        else
          format.html { render :edit }
          format.json { render json: @season.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /seasons/1
  # DELETE /seasons/1.json
  def destroy
    league = @season.league
    @season.destroy
    respond_to do |format|
      format.html { redirect_to show_league_path(league), notice: 'Season was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def portfolio_index
    @portfolios = @season.portfolios
  end
  
  def portfolio_view
    @season = Season.find(params[:season_id])
    @portfolio = User.find(params[:portfolio_id])
    @holdings = @portfolio.holdings
  end
  
  def initiate_add_holdings
    @season = Season.find(params[:season_id])
    @portfolio = Portfolio.find(params[:portfolio_id])
  end
  
  def handle_add_holding
    @season = Season.find(params[:season_id])
    @portfolio = Portfolio.find(params[:portfolio_id])
    
    holding_params = params.require(:holding).permit(:team_id, :amount)
    @team = Team.find(holding_params[:team_id])
    
    if !@team
      @errors = ['Team not found']
      render :initiate_add_holdings
    elsif !@portfolio
      @errors = ['No such player']
      render :initiate_add_holdings
    elsif holding_params[:amount] <= 0
      @errors = ['Amount must be more than 0']
      render :initiate_add_holdings
    else
      holding = @portfolio.holdings.select{|holding| holding.team == @team}.first
      
      if !holding
        holding = Holding.new(holding_params)
        holding.portfolio = @portfolio
      else
        holding.amount += holding_params[:amount]
      end
      
      if holding.save
        redirect_to season_portfolio_view_path(season_id: params[:season_id], portfolio_id: params[:portfolio_id])
      else
        @errors = ['Unable to add holding']
        render :initiate_add_holdings
      end
    end
  end
  
  def edit_holding
    @season = Season.find(params[:season_id])
    @holding = Holding.find(params[:holding_id])
  end
  
  def update_holding
    @season = Season.find(params[:season_id])
    @holding = Holding.find(params[:holding_id])
    holding_edit_params = params.require(:holding).permit(:amount)
    
    if holdings_edit_params[:amount] < 0
      @errors = ['Amount must be more than 0']
      render :edit_holding
    else
      if @holding.update(holding_edit_params)
        redirect_to season_portfolio_view_path(season_id: params[:season_id], portfolio_id: @holding.portfolio)
      else
        @error = ['Unable to update holding']
        render :edit_holding
      end
    end
  end
  
  def delete_holding
    @season = Season.find(params[:season_id])
    @holding = Holding.find(params[:holding_id])
    
    if holding.destroy
      redirect_to season_portfolio_view_path(season_id: params[:season_id], portfolio_id: @holding.portfolio)
    else
      redirect_to season_portfolio_view_path(season_id: params[:season_id], portfolio_id: @holding.portfolio), warning: 'Unable to delete holding'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season
      @season = Season.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def season_params
      params.require(:season).permit(:name)
    end
end
