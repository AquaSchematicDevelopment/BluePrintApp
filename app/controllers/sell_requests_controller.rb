class SellRequestsController < ApplicationController
  before_action :set_sell_request, only: [:show, :edit, :update, :destroy]

  # GET /sell_requests
  # GET /sell_requests.json
  def index
    @sell_requests = SellRequest.all
  end

  # GET /sell_requests/1
  # GET /sell_requests/1.json
  def show
  end

  # GET /sell_requests/new
  def new
    @sell_request = SellRequest.new
    @holding = Holding.find(params[:holding_id])
  end

  # GET /sell_requests/1/edit
  def edit
  end

  # POST /sell_requests
  # POST /sell_requests.json
  def create
    @holding = Holding.find(params[:holding_id])
    @sell_request = SellRequest.new(sell_request_params)
    @sell_request.team = @holding.team
    @sell_request.portfolio = @holding.portfolio
    
    if @holding.portfolio.user != current_user
      @errors = ["Request from wrong user."]
      redirect_to root
    elsif @holding.available_blueprints < @sell_request.amount
      @errors = ["You don't have that many BluePrints available for that team."]
      render :new
    else
      if @sell_request.save
        redirect_to show_portfolio_path, notice: 'Sell request was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /sell_requests/1
  # PATCH/PUT /sell_requests/1.json
  def update
    if @sell_request.update(sell_request_params)
      redirect_to @sell_request, notice: 'Sell request was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sell_requests/1
  # DELETE /sell_requests/1.json
  def destroy
    @sell_request.destroy
    respond_to do |format|
      format.html { redirect_to sell_requests_url, notice: 'Sell request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sell_request
      @sell_request = SellRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sell_request_params
      params.require(:sell_request).permit(:price, :amount)
    end
end
