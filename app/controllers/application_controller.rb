# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorized
  helper_method :logged_in?
  helper_method :current_user

  protected 
  def current_user
      if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
     # redirect_to '/welcome' unless logged_in?
   end
end
