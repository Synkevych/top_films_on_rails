# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action: :set_article

  # def search_by_text(text)
  #   @articles = Article.where('lower(text) like ?', "%#{@search.downcase}%")
  # end

  def index
    if params.key? :search
      @search = params[:search]
      @articles = Article.where('lower(title) like ?', "%#{@search.downcase}%")
      if @articles.empty?
        @articles = Article.where('lower(text) like ?', "%#{@search.downcase}%")
      end
    else
      @articles = Article.all
      end
  end

  def create_new_img(new_img)
    new_img_url = Cloudinary::Uploader.upload(new_img)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    unless params[:article][:image].nil?
      new_img_url = create_new_img(params[:article][:image])
      @article.update(image: new_img_url['url'])
    end

    if @article.save
      redirect_to @article
    else
      render 'new'
   end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
     end
  end

  def destroy
    if @article.errors.present?
      throw(:abort)
    else
      if @article.destroy
        flash[:success] = "Successfully deleted!"
      else
        flash[:error] = "Something went wrong, the acticle wasn't deleted"
      end
    end
    
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :user_id)
  end
end
