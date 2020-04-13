# frozen_string_literal: true

class UsersController < ApplicationController
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
    
    if @user.save
      flash[:info] = "Well done you registered!"
      session[:user_id] = @user.id
      redirect_to '/welcome'

    else
      redirect_to 'new'
    end
  end

  def update

    current_user.update(user_param)

    redirect_to '/welcome'
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end


  def user_param
    params.require(:user).permit(:username, :password, :avatar)
  end
end
