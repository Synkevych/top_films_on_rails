# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :find_article,  only: [ :show, :update, :destroy, :edit ]

  def index
    @articles = Article.all
    @articles = Article.where('lower(title) LIKE ? OR lower(text) LIKE ?',
     "%#{params[:search].downcase}%",
     "%#{params[:search].downcase}%") if params.key? :search
    @articles = @articles
      .order('created_at DESC')
      .includes(:user)
      .paginate(page: params[:page])
  end 
    
  def show
    @comments = @article.comments.order('created_at DESC').paginate(page: params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    #new_img_url = create_new_img(params[:article][:image]) if !params[:article][:image].present?

    @article = Article.new(article_params)
    #@article.update(image: new_img_url['url'])
    # if @article.valid?
    #   flash[:success] = "Article successfully created!"
    #   redirect_to @article
    # else
    #    flash[:alert] = "With creating Acticle was some problem!"
    #   render 'new'
    # end
    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_path, notice: 'Article successfully created!'}
        format.json { render :show, status: :created, notice: @article}
        format.js
      else
        format.html { render :new }
        format.json { render json, @article.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    # if @article.update(article_params)
    #   flash[:success] = "Successfully updated!"
    #   redirect_to @article
    # else
    #   render 'edit'
    #  end
    @article.update(article_params)
    respond_to do |format|
    if @article.save
      format.html { redirect_to articles_path, notice: 'Article successfully updated!'}
      format.json { render :show, status: :ok, location: @article}
      format.js
    else
      format.html { render :new }
      format.json { render json, @article.errors, status: :unprocessable_entity }
      format.js
    end
  end
  end

  def destroy

    if @article.destroy
    #   flash[:success] = "Successfully deleted!"
    # else
    #   flash[:error] = "Something went wrong, the acticle wasn't deleted"
    # end
    # redirect_to articles_path
    respond_to do |format| 
      format.js
      format.html { redirect_to articles_path, notice: 'Post was successfully destroyed.'}
      format.json { head :no_content }
    end
  end
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  # def create_new_img(new_img)
  #   new_img_url = Cloudinary::Uploader.upload(new_img)
  # end

  def article_params
    params.require(:article).permit(:title, :text, :user_id)
  end
end
