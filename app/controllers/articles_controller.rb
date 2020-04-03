# frozen_string_literal: true

# To save data we need create here some logic

class ArticlesController < ApplicationController
  
  $comment_form_hidden = false

  def index

    if params.has_key? :search
      @search = params[:search]
      @article = Article.where("title like ?", "%#{@search}%")
      else
        @articles = Article.all
      end
    # @search = params['seach']
    # @article = @search['title'] if @search.present?
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
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
   end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
     end
  end

  def destroy
    #  проверка перед удалением на ошибки 

    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def searching
    @searching = params[:search_request]
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
