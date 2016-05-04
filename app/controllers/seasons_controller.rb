class SeasonsController < ApplicationController
  before_action :set_season, only: 
    [:show, :edit, :update, :destroy, :sell_request_index, :buy_request_index, :initiate_manage, :handle_manage]
    
  before_action :redirect_non_user
  before_action :redirect_non_user, only: [:join_index, :join]
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
    @season.status = :unpublished
    
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
  
  def initiate_manage
  end
  
  def handle_manage
    if Season.check_valid_status(manage_season_params[:status])
      @errors = ['Invalid status']
      render :initiate_manage
    else
      if @season.update(manage_season_params)
        redirect_to show_season_path(@season)
      else
        @errors = []
        render :initiate_manage
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
  
  def sell_request_index
    @teams = @season.teams.sort_by{|team| team.name }
  end
  
  def buy_request_index
    @teams = @season.teams.select{|team| current_portfolio.holdings.find_by(team: team)}.sort_by{|team| team.name }
  end
  
  def join_index
    @seasons = Season.all.select{|season| season.active? } - current_user.portfolios.map{|portfolio| portfolio.season}
  end
  
  def join
    if !current_user.portfolios.map{|portfolio| portfolio.season}.find(@season).empty?
      redirect_to root_path, notice: 'Unable to join season1'
    elsif !@season.active?
      redirect_to root_path, notice: 'Unable to join season2'
    else
      portfolio = Portfolio.new()
      portfolio.user = current_user
      portfolio.season = @season
      
      if portfolio.save()
        redirect_to root_path
      else
        redirect_to root_path, warning: 'Unable to join season3'
      end
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
    
    def manage_season_params
      params.require(:season).permit(:status)
    end
end
