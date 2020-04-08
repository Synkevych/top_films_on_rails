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

  def create_img(img_file)
    if !img_file.nil?
      @value = Cloudinary::Uploader.upload(img_file)
    end

  end


  def create
    
    @user = User.create!( user_param)
    
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
    
 
    current_user.update(params[:user][:username][:password], :avatar_url => create_img(params[:user][:avatar]['url']))
    # cl_image_tag("hw17tqpdnliid6ltrism.png")
    
    redirect_to '/welcome'

  end 

  def user_param
    params.require(:user).permit(:username, :password )
  end
end
