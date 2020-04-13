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
    session[:user_id] = @user.id

    if @user.valid?
      @user.save
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

  # def create_reset_digest
  #   self.reset_token = User.new_token update_attribute(:reset_digest, User.digest(reset_token)) update_attribute(:reset_sent_at, Time.zone.now)
  # end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  private 

  def set_user
    @user = User.find(params[:id])
  end

  def user_param
    params.require(:user).permit(:username, :password, :avatar)
  end
end
