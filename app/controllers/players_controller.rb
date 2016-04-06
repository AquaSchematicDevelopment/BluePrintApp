class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :redirect_non_user
  before_action :redirect_non_admin, only: [:index, :new, :create, :destroy]
  
  def index
    @players = User.where(role: :player)
  end
  
  def show
  end

  def new
    @player = User.new
  end

  def edit
  end

  def create
    @player = User.new(player_params)
    @player.role = :player
    
    if User.find_by_name(@player.name)
      @errors = ['A user with that name already exists']
      render :new
    else
      respond_to do |format|
        if !User.find_by_name(@player.name) && @player.save
          format.html { redirect_to players_path, notice: 'Player was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if User.find_by_name(player_params[:name]) && @user.name != player_params[:name]
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to players_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @player
      @player.destroy
      respond_to do |format|
        format.html { redirect_to player_index_path, notice: 'Player was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to player_index_path, notice: 'User is not a player.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      user = User.find(params[:id])
      @player = user if user.is_player?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :email, :password, :password_confirmation)
    end
end
