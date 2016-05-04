class ProfilesController < ApplicationController
  before_action :redirect_non_user

  def show
  end

  def change_password
  end

  def update_password
    if !current_user.authenticate(password_params[:old_password])
      @errors = ['Old password was incorrect']
      render :change_password
    elsif password_params[:new_password].length < 6
      @errors = ['New password must be at least 6 characters long']
      render :change_password
    else
      respond_to do |format|
        if current_user.update(password: password_params[:new_password], password_confirmation: password_params[:password_confirmation])
          format.html { redirect_to profile_path, notice: 'Your password was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :change_password }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def password_params
      params.require(:profile).permit(:new_password, :password_confirmation, :old_password)
    end
end
