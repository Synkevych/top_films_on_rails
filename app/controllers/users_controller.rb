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
    @user = User.create!(params.require(:user).permit(:username, :password))

    session[:user_id]= @user.id

    if @user
        redirect_to '/welcome'
    
      else
      redirect_to '/users/new'
    end
    
  end

  def update
    @user = User.find(params[:user][:id])
    if @user.update(params[:user][:username])
      redirect_to '/welcome'
    end
    redirect_to '/welcome'

  end 

end
