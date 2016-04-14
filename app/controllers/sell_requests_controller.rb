class SellRequestsController < ApplicationController
  before_action :redirect_non_user
  before_action :redirect_non_player, only: [:new, :create, :initiate_buy, :process_buy]
  before_action :set_sell_request, only: [:show, :edit, :update, :initiate_buy, :process_buy, :destroy]

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
    elsif !@sell_request.amount || !@sell_request.price
      @errors = ['Form was incomplete']
      render :new
    elsif @holding.available_blueprints < @sell_request.amount
      @errors = ["You don't have that many BluePrints available for that team."]
      render :new
    elsif @sell_request.amount <= 0 || @sell_request.price <= 0
      @errors = ['Either price or amount is zero']
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
  
  def initiate_buy
    # TODO
    @transaction = Transaction.new
    
    if @sell_request.portfolio.user == current_user
      redirect_to team_sell_requests_path(@sell_request.team), notice: "You can't buy your own Blueprints."
    end
  end
  
  def process_buy
    # TODO
    @from_portfolio = @sell_request.portfolio
    @to_portfolio = current_portfolio
    
    raise unless @from_portfolio
    
    @transaction = Transaction.new(transaction_params)
    @transaction.team = @sell_request.team
    @transaction.price = @sell_request.price
    @transaction.from_portfolio = @from_portfolio
    @transaction.to_portfolio = @to_portfolio
    
    if @sell_request.portfolio.user == current_user
      redirect_to team_sell_requests_path(@sell_request.team), notice: "You can't buy your own Blueprints."
    elsif !@transaction.amount || @transaction.amount <= 0
      @errors = ["You didn't input a valid amount."]
      render :initiate_buy
    elsif @transaction.amount > @sell_request.amount
      @errors = ["You can't buy more Blueprints than are being offered."]
      render :initiate_buy
    elsif @transaction.amount * @sell_request.price > current_user.funds
      @errors = ["You don't have enough funds."]
      render :initiate_buy
    else
     handle_buy
    end
  end

  # DELETE /sell_requests/1
  # DELETE /sell_requests/1.json
  def destroy
    if @sell_request.portfolio.user == current_user
      @sell_request.destroy
      redirect_to show_portfolio_path, notice: 'Sell request was successfully deleted.'
    else
      redirect_to root, notice: 'Wrong User'
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
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params
    params.require(:transaction).permit(:amount)
  end
  
  class DatabaseException < Exception
  end
  
  def handle_buy
    # This is a generic message for when there is an error in processing the transaction
    # but all the changes to the database were able to be undone.
    error_message = "There was a problem when processing the transaction."
    
    # This is a generic message for when there is an error in processing the transaction
    # but all the changes to the databasse weren't able to be undone.
    # This is a major problem, because it means that funds or blueprints could be incorrect in the database.
    critical_error_message = "There was a critical error when processing your transaction. Please contact one of our admins."
    
    # an array for storing lambdas that will handle undoing the changes that have been
    # made to the datebase
    undos = []
    
    # move funds
    total = @transaction.amount * @transaction.price
    
    @to_user = @to_portfolio.user
    @from_user = @from_portfolio.user
    
    @to_user.funds -= total
    @from_user.funds += total
    
    raise DatabaseException unless @to_user.update
    undos[] = lambda do
      @to_user.funds += total
      raise DatabaseException unless @to_user.update
    end
    
    raise DatabaseException unless @from_user.update
    undos[] = lambda do
      @from_user.funds -= total
      raise DatabaseException unless @from_user.update
    end
    
    # move holdings
    
    @to_holding = @to_portfolio.holdings.find_by(team: @transaction.team)
    unless to_holding
      @to_holding = Holding.create(portfolio: @to_portfolio, team: @transaction.team, blue_prints: 0)
      undos[] = lambda do
        raise DatabaseException unless @to_holding.delete
      end
    end
    
    @from_holding = @from.holdings.find_by(team: @transaction.team)
    raise DatabaseException unless @from_holding
    
    to_holding.amount += @transaction.amount
    from_holding.amount -= @transaction.amount
    
    raise DatabaseException unless to_holding.update
    undos[] = lambda do
      to_holding.amount -= @transaction.amount
      raise DatabaseException unless to_holding.update
    end
    
    raise DatabaseException unless from_holding.update
    undos[] = lambda do
      from_holding.amount += @transaction.amount
      raise DatabaseException unless from_holding.update
    end
    
    # add transaction to data base
    @sell_request_save[portfolio: @sell_request.portfolio, amount: @sell_request.amount, price: @sell_request.price, team: @sell_request.team]
    
    @sell_request.amount -= @transaction.amount
    
    if @sell_request.amount == 0
      raise DatabaseException unless @sell_request.belete
      undos[] = lambda do
        raise DatabaseException unless SellRequest.create(@sell_request_save)
      end
    else
      raise DatabaseException unless @sell_request.update
      undos[] = lambda do
        @sell_request.amount += @transaction.amount
        raise DatabaseException unless @sell_request.update
      end
    end
    
    # reduce amount of sell_request
    
    raise DatabaseException unless @transaction.update
    
    # everything is now safe
    undos = nil
    
    redirect_to show_portfolio, notice: "Your transaction was successfully processed."
    
  rescue => error
    begin
      if undos
        undos.reverse.each { |undo| undo.call }
      end
      @errors = [error_message, error.message + ': ' + error.backtrace.to_s]
      render :initiate_buy
    rescue => critical_error
      @errors = [critical_error_message, error.message + ': ' + error.backtrace.to_s, critical_error.message + ': ' + critical_error.backtrace.to_s]
      redirect root, notice: 'The following error accured on this site: ' + @errors.to_s
    end
  end
end
