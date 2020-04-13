# frozen_string_literal: true

class ArticlesController < ApplicationController
# before_action :set_article

  def index
    if params.key? :search
      @search = params[:search].downcase
      @articles = Article.where('lower(title) LIKE ? OR lower(text) LIKE ?', "%#{@search}%", "%#{@search}%")
      paginate_articles(@articles)
    else
      paginate_articles(Article.includes(:user))
    end
  end

  def paginate_articles(articles)
      @articles = articles
      .order("created_at DESC")
      .paginate(:page =>  params[:page])
  end 
    
  def show
    @article =  Article.find(params[:id])
    @comments = @article.comments.paginate(:page=> params[:page])
  end

  def new
    @article = Article.new
    #@article = current_user.articles.build 
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    new_img_url = create_new_img(params[:article][:image])

    @article = Article.new(article_params)
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
    @article = session[:user_id].articles.find(params[:id])
  #  @article = @article.comments.all.order("created_at DESC")
  end

  def create_new_img(new_img)
    new_img_url = Cloudinary::Uploader.upload(new_img)
  end

  def article_params
    params.require(:article).permit(:title, :text, :user_id)
  end
end
