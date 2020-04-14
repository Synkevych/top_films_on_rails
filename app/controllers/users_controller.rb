# frozen_string_literal: true

class UsersController < ApplicationController

  #attr_accessor :reset_token
  skip_before_action :authorized, only: %i[new create]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.create!(user_param)
    
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      flash[:success] = 'New user created!'
      redirect_to '/welcome'
       
    else
      flash[:danger] = 'Invalid user/password combination'
      redirect_to '/users/new'
    end
  end

  def update
    current_user.update(user_param)
    redirect_to '/welcome'
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
    redirect_to login_path
  end
  
  private 

  def user_param
    params.require(:user).permit(:username, :password, :email, :avatar)
  end
end
