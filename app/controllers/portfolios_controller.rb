class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:edit, :update, :destroy]
  before_action :redirect_non_user
  before_action :redirect_non_player, only: [:show]

  # GET /portfolios
  # GET /portfolios.json
  def index
    @portfolios = Portfolio.all
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
    @portfolio = current_portfolio
    @holdings = @portfolio.holdings.sort_by{|holding| holding.team.name}
    @sell_requests = @portfolio.sell_requests.sort do |a,b|
         by_team = a.team.name <=> b.team.name
         #by_price = a.price <=> b.price if by_team == 0
         #by_amount = a.amount<=> b.amount if by_price && by_price == 0
         
         if by_team == 0
           by_price = b.price <=> a.price
           if by_price == 0
             a.amount<=> b.amount
           else
             by_price
           end
         else
           by_team
         end
       end
  end

  # GET /portfolios/new
  def new
    @portfolio = Portfolio.new
  end

  # GET /portfolios/1/edit
  def edit
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio }
      else
        format.html { render :new }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolios/1
  # PATCH/PUT /portfolios/1.json
  def update
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully updated.' }
        format.json { render :show, status: :ok, location: @portfolio }
      else
        format.html { render :edit }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_params
      params.require(:portfolio).permit(:funds)
    end
end
