# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create welcome articles]

  # before_action :set_default

  # def set_default
  #   session[:user_id] ||= 0
  # end

  def new; end

  def create
    # use to
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/welcome'
    else
      flash[:danger] = 'Invalid user/password combination'
      render 'new'
    end
  end

  def welcome; end

  def login; end

  def page_requires_login; end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end
end
