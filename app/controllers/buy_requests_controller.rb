class BuyRequestsController < ApplicationController
  before_action :set_buy_request, only: [:show, :edit, :update, :destroy, :initiate_sell, :process_sell]
  before_action :redirect_non_player, only: [:new, :create, :initiate_sell, :process_buy]

  # GET /buy_requests
  # GET /buy_requests.json
  def index
    @buy_requests = BuyRequest.all
  end

  # GET /buy_requests/1
  # GET /buy_requests/1.json
  def show
  end

  # GET /buy_requests/new
  def new
    @team = Team.find(params[:team_id])
    @buy_request = BuyRequest.new
  end

  # GET /buy_requests/1/edit
  def edit
  end

  # POST /buy_requests
  # POST /buy_requests.json
  def create
    @team = Team.find(params[:team_id])
    @buy_request = BuyRequest.new(buy_request_params)
    @buy_request.team = @team
    @buy_request.portfolio = current_portfolio
    
    if @buy_request.portfolio.user != current_user
      @errors = ["Request from wrong user."]
      redirect_to root
    elsif !@buy_request.amount || !@buy_request.price
      @errors = ['Form was incomplete']
      render :new
    elsif current_user.funds < @buy_request.amount * @buy_request.price
      @errors = ["You don't have enough funds."]
      render :new
    elsif @buy_request.amount <= 0 || @buy_request.price <= 0
      @errors = ['Either price or amount is zero']
      render :new
    else
      if @buy_request.save
        redirect_to show_portfolio_path, notice: 'Buy request was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /buy_requests/1
  # PATCH/PUT /buy_requests/1.json
  def update
    respond_to do |format|
      if @buy_request.update(buy_request_params)
        format.html { redirect_to @buy_request, notice: 'Buy request was successfully updated.' }
        format.json { render :show, status: :ok, location: @buy_request }
      else
        format.html { render :edit }
        format.json { render json: @buy_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buy_requests/1
  # DELETE /buy_requests/1.json
  def destroy
    @buy_request.destroy
    respond_to do |format|
      format.html { redirect_to buy_requests_url, notice: 'Buy request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def initiate_sell
    @transaction = Transaction.new
    @holding = current_portfolio.holdings.find_by(team: @buy_request.team)
    
    if @buy_request.portfolio.user == current_user
      redirect_to team_buy_requests_path(@buy_request.team), notice: "You can't buy your own Blueprints."
    end
  end
  
  def process_sell
    buyer_portfolio = @buy_request.portfolio
    seller_portfolio = current_portfolio
    
    @transaction = Transaction.new(transaction_params)
    
    holding = seller_portfolio.holdings.find_by(@transaction.team)
    
    if @buy_request.portfolio.user == current_user
      redirect_to team_sell_requests_path(@sell_request.team), notice: "You can't buy your own Blueprints."
    elsif !@transaction.amount || @transaction.amount <= 0
      @errors = ["You didn't input a valid amount."]
      render :initiate_sell
    elsif @transaction.amount > @buy_request.amount
      @errors = ["You can't buy more Blueprints than are being offered."]
      render :initiate_sell
    elsif !holding || @transaction.amount > holding.blue_prints
      @errors = ["You don't have enough bluprints."]
      render :initiate_sell
    else
      sell_request = SellRequest.create(portfolio: seller_portfolio, team: @buy_request.team, price: @buy_request.price, amount: @transaction.amount)
      begin
        Transaction.handle_transaction buy_request: @buy_request , sell_request: sell_request
        redirect_to show_portfolio_path, notice: "Your transaction was successfully processed."
      rescue => error
        raise 'fatal error' unless sell_request.destroy
        raise error
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buy_request
      @buy_request = BuyRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buy_request_params
      params.require(:buy_request).permit(:amount, :price)
    end
    
  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
