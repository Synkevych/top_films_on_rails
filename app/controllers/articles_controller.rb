# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article

  def index
    if params.key? :search
      @search = params[:search].downcase
      @articles = Article.where('lower(title) LIKE ? OR lower(text) LIKE ?', "%#{@search}%", "%#{@search}%")
      paginate(@articles)
    else
      paginate(@Article.all)
    end
  end

  def paginate(articles)
      @article = articles.all.order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end 

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    #@article = current_user.articles.build 
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    user = User.find_by(id: current_user.id)

    new_img_url = create_new_img(params[:article][:image])

    @article = Article.new(article_params)
    #@article['user_id'] = user.id
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

  def create_new_img(new_img)
    new_img_url = Cloudinary::Uploader.upload(new_img)
  end

  def article_params
    params.require(:article).permit(:title, :text, :user_id)
  end
end
