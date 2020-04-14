class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]

  def new
  end

  def create
      @user = User.find_by(email: params[:password_reset][:email].downcase)

      if @user
        @user.create_reset_digest
        @user.send_password_reset_email
        flash[:info] = "Email sent with password reset instructions" 
        redirect_to root_url
      else
       flash[:danger] = "Email address not found"
       render 'new'
      end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      flash[:alert] = "Password can't be empty."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params.require(:user).permit(:password))
      flash[:success] = "Password has been reseted."
      redirect_to login_path
    else
      render :edit
    end
  end

  private
  
  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirm a valid user
  def valid_user
    unless (@user && @user.authenticated?(:reset, params[:id]))
          redirect_to login_path
    end
  end
end
