class SportsController < ApplicationController
  before_action :set_sport, only: [:show, :edit, :update, :destroy]
  before_action :redirect_non_user
  before_action :redirect_non_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # GET /sports
  # GET /sports.json
  def index
    @sports = Sport.all
  end

  # GET /sports/1
  # GET /sports/1.json
  def show
    @leagues = @sport.leagues
  end

  # GET /sports/new
  def new
    @sport = Sport.new
  end

  # GET /sports/1/edit
  def edit
  end

  # POST /sports
  # POST /sports.json
  def create
    @sport = Sport.new(sport_params)
    
    if Sport.find_by(name: sport_params[:name])
      @errors = ['A sport with that name already exists']
      render :new
    else
      respond_to do |format|
        if @sport.save
          format.html { redirect_to show_sport_path(id: @sport.id), notice: 'Sport was successfully created.' }
          format.json { render :show, status: :created, location: @sport }
        else
          format.html { render :new }
          format.json { render json: @sport.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /sports/1
  # PATCH/PUT /sports/1.json
  def update
    if Sport.find_by(name: sport_params[:name]) && @sport.name != sport_params[:name]
      @errors =['A sport with that name already exists']
      render :edit
    else
      respond_to do |format|
        if @sport.update(sport_params)
          format.html { redirect_to show_sport_path(id: @sport.id), notice: 'Sport was successfully updated.' }
          format.json { render :show, status: :ok, location: @sport }
        else
          format.html { render :edit }
          format.json { render json: @sport.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /sports/1
  # DELETE /sports/1.json
  def destroy
    @sport.destroy
    respond_to do |format|
      format.html { redirect_to sports_path, notice: 'Sport was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport
      @sport = Sport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sport_params
      params.require(:sport).permit(:name)
    end
end
