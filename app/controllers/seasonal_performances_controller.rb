class SeasonalPerformancesController < ApplicationController
  before_action :set_seasonal_performance, only: [:show, :edit, :update, :destroy]

  # GET /seasonal_performances
  # GET /seasonal_performances.json
  def index
    @seasonal_performances = SeasonalPerformance.all
  end

  # GET /seasonal_performances/1
  # GET /seasonal_performances/1.json
  def show
  end

  # GET /seasonal_performances/new
  def new
    @seasonal_performance = SeasonalPerformance.new
  end

  # GET /seasonal_performances/1/edit
  def edit
  end

  # POST /seasonal_performances
  # POST /seasonal_performances.json
  def create
    @seasonal_performance = SeasonalPerformance.new(seasonal_performance_params)

    respond_to do |format|
      if @seasonal_performance.save
        format.html { redirect_to @seasonal_performance, notice: 'Seasonal performance was successfully created.' }
        format.json { render :show, status: :created, location: @seasonal_performance }
      else
        format.html { render :new }
        format.json { render json: @seasonal_performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seasonal_performances/1
  # PATCH/PUT /seasonal_performances/1.json
  def update
    respond_to do |format|
      if @seasonal_performance.update(seasonal_performance_params)
        format.html { redirect_to @seasonal_performance, notice: 'Seasonal performance was successfully updated.' }
        format.json { render :show, status: :ok, location: @seasonal_performance }
      else
        format.html { render :edit }
        format.json { render json: @seasonal_performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seasonal_performances/1
  # DELETE /seasonal_performances/1.json
  def destroy
    @seasonal_performance.destroy
    respond_to do |format|
      format.html { redirect_to seasonal_performances_url, notice: 'Seasonal performance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seasonal_performance
      @seasonal_performance = SeasonalPerformance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seasonal_performance_params
      params.require(:seasonal_performance).permit(:book_value, :team_id, :season_id)
    end
end
