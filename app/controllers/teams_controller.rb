class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :sell_request_index]
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
    @team = Team.new(team_params)
    @team.season_id = params[:season_id]
    
    if Team.where(season_id: params[:season_id], name: team_params[:name]).first
      @errors = ['There already exists a team with that name in the season']
      render :new
    else
      respond_to do |format|
        if @team.save
          format.html { redirect_to show_team_path(@team), notice: 'Team was successfully created.' }
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
    if Team.where(season_id: @team.season_id, name: team_params[:name]).first && @team.name != team_params[:name]
      @errors = ['There already exists a team with that name in the season']
      render :edit
    elsif !number_or_nil(team_params[:book_value]) || number_or_nil(team_params[:book_value]) < 0
      @errors = ['The book price must be a positive number']
      render :edit
    else
      respond_to do |format|
        if @team.update(team_params)
          format.html { redirect_to show_team_path(@team), notice: 'Team was successfully updated.' }
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
    season = @team.season
    @team.destroy
    respond_to do |format|
      format.html { redirect_to show_season_path(season), notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def sell_request_index
    @sell_requests = @team.sell_requests.reject{|sell_request| sell_request.portfolio.user == current_user}.sort_by {|sell_request| sell_request.price}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :book_value)
    end
end
