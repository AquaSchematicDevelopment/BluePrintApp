class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]
  before_action :redirect_non_user
  before_action :redirect_non_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.where(sport_id: params[:sport_id])
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
  end

  # GET /leagues/new
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(league_params)
    @league.sport_id = params[:sport_id]
    
    if League.find_by(name: league_params[:name])
      @errors = ['A League with that name already exists']
      render :new
    else
      respond_to do |format|
        if @league.save
          format.html { redirect_to show_league_path(@league), notice: 'League was successfully created.' }
          format.json { render :show, status: :created, location: @league }
        else
          format.html { render :new }
          format.json { render json: @league.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  def update
    if League.find_by(name: league_params[:name])
      @errors = ['A Leaugue with that name already exists']
      render :edit
    else
      respond_to do |format|
        if @league.update(league_params)
          format.html { redirect_to show_league_path(@league), notice: 'League was successfully updated.' }
          format.json { render :show, status: :ok, location: @league }
        else
          format.html { render :edit }
          format.json { render json: @league.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to leagues_url, notice: 'League was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name)
    end
end
