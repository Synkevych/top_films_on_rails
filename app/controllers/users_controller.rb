# frozen_string_literal: true

class UsersController < ApplicationController

  #attr_accessor :reset_token
  before_action :find_user, only: [:show, :edit]
  skip_before_action :authorized, only: %i[new create]

  def show
  end

  def new
    @user = User.new
  end

  def edit
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
      render 'new'
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

  def find_user
    @user = User.find(params[:id])
  end 

  def user_param
    params.require(:user).permit(:username, :password, :email, :avatar)
  end
end
