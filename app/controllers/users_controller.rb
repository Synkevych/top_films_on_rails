class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]
  

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

    @value = Cloudinary::Uploader.upload(params[:user][:avatar])

    @user = User.create!(params[:user][:username][:password], :avatar => @value['url'])
    
    @user.save
    #@user = User.create!(user_param)

    session[:user_id]= @user.id

    if @user
        redirect_to '/welcome'
    
      else
      redirect_to '/users/new'
    end
    
  end

  def update
    current_user.update(user_param)
    redirect_to '/welcome'

  end 

  def user_param
    params.require(:user).permit(:username, :password, :avatar)
  end
end
