# frozen_string_literal: true

class ArticlesController < ApplicationController
   before_action :set_article

  def index
    if params.has_key? :search
      @search = params[:search]
      @articles = current_user.articles.where("title like ?", "%#{@search}%")
    else
      @articles = current_user.articles
    end  
  end

  def create_new_img(new_img)
    new_img_url = Cloudinary::Uploader.upload(new_img)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build 
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    new_img_url = create_new_img(params[:article][:image])

    @article = current_user.articles.create(article_params)
    #@article[image] = new_img_url['url']
    @article.update(image: new_img_url['url'])

    if @article.save
      flash[:success] = "Article successfully created!"
      redirect_to @article
    else
       flash[:alert] = "With creating Acticle was some problem!"
      render 'new'
   end

  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      flash[:success] = "Successfully updated!"
      redirect_to @article
    else
      render 'edit'
     end
  end

  def destroy
    @article = Article.find(params[:id])

      if @article.destroy
        flash[:success] = "Successfully deleted!"
      else
        flash[:error] = "Something went wrong, the acticle wasn't deleted"
      end

    redirect_to articles_path
  end

  private

  def set_article
    @article = current_user.articles.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text )
  end
end
