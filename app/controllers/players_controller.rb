class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :redirect_non_user
  before_action :redirect_non_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  
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
    @player.funds = 0.00
    
    if User.find_by_name(@player.name)
      @errors = ['A user with that name already exists']
      render :new
    elsif @player.name.length < 3
      @errors = ["User's name needs to be at least 3 characters long"]
      render :new
    elsif player_params[:password]. length < 6
      @errors = ["Passwords must be at least 6 characters long"]
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
    if update_player_params[:funds] < 0
      @errors = ["Player can't have negative funds"]
      render :edit
    else
      respond_to do |format|
        if @player.update(update_player_params)
          format.html { redirect_to players_path, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if @player
      @player.destroy
      respond_to do |format|
        format.html { redirect_to players_path, notice: 'Player was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to player_index_path, notice: 'User is not a player.' }
        format.json { head :no_content }
      end
    end
  end
  
  def initiate_change_password
  end
  
  def handle_change_password
    if password_params[:new_password].length < 6
      @errors = ['New password must be at least 6 characters long']
      render :change_password
    else
      respond_to do |format|
        if @player.update(password: password_params[:new_password], password_confirmation: password_params[:password_confirmation])
          format.html { redirect_to players_path, notice: 'Your password was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :change_password }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      user = User.find(params[:id])
      if user.is_player?
        @player = user
      else
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :email, :password, :password_confirmation)
    end
    
    def update_player_params
      params.require(:player).permit(:funds)
    end
end
