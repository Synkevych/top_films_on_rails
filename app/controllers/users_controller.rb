# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[new create]

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    # проверить роль admin или user  иначе давать ошибку
    @user = User.create!(user_param)

    unless params[:user][:avatar].nil?
      new_img_url = create_new_img(params[:user][:avatar])
      @user.update(avatar: new_img_url['url'])
    end

    @user.save

    session[:user_id] = @user.id

    if @user
      redirect_to '/welcome'

    else
      redirect_to '/users/new'
    end
  end

  def update
    unless params[:user][:avatar].nil?
      new_img_url = create_new_img(params[:user][:avatar])
      current_user.update(avatar: new_img_url['url'])

    end
    current_user.update(user_param)

    redirect_to '/welcome'
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end

  def create_new_img(new_img)
    new_img_url = Cloudinary::Uploader.upload(new_img)
  end

  def user_param
    params.require(:user).permit(:username, :password)
  end
end
