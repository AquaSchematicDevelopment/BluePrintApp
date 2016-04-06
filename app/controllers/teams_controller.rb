class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :redirect_non_user
  before_action :redirect_non_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.where(season_id: params[:season_id])
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    if Team.where(season_id: params[:season_id], name: team_params[:name])
      @errors = ['There already exists a team with that name in the league']
      render :new
    else
      @team = Team.new(team_params)
      @team.season_id = params[:season_id]
  
      respond_to do |format|
        if @team.save
          format.html { redirect_to @team, notice: 'Team was successfully created.' }
          format.json { render :show, status: :created, location: @team }
        else
          format.html { render :new }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if Team.where(season_id: @team.season_id, name: team_params[:name]) && @team.name != team_params[:name]
      @errors = ['There already exists a team with that name in the league']
      render :new
    else
      respond_to do |format|
        if @team.update(team_params)
          format.html { redirect_to @team, notice: 'Team was successfully updated.' }
          format.json { render :show, status: :ok, location: @team }
        else
          format.html { render :edit }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
