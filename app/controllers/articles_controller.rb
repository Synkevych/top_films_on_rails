# frozen_string_literal: true

class ArticlesController < ApplicationController
  $comment_form_hidden = false

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
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    new_img_url = create_new_img(params[:article][:image])

    @article = Article.new(article_params)
    #@article[image] = new_img_url['url']
    @article.update(image: new_img_url['url'])

    if @article.save
      flash[:success] = "Successfully created!"
      redirect_to @article
    else
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

  def article_params
    params.require(:article).permit(:title, :text, :user_id)
  end
end
