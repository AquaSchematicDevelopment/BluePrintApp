class BuyRequestsController < ApplicationController
  before_action :set_buy_request, only: [:show, :edit, :update, :destroy]

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
    @buy_request = BuyRequest.new(buy_request_params)

    respond_to do |format|
      if @buy_request.save
        format.html { redirect_to @buy_request, notice: 'Buy request was successfully created.' }
        format.json { render :show, status: :created, location: @buy_request }
      else
        format.html { render :new }
        format.json { render json: @buy_request.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buy_request
      @buy_request = BuyRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buy_request_params
      params.require(:buy_request).permit(:amount, :price)
    end
end
