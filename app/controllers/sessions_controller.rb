# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create welcome articles]

  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You are successfuly login in!'
      redirect_to '/welcome'
    else
      flash[:danger] = 'Invalid user/password combination'
      redirect_to login_path
    end
  end

  def welcome; end

  def login; end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end

end
