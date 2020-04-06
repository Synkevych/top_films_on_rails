# frozen_string_literal: true

# To save data we need create here some logic

class ArticlesController < ApplicationController
  
  $comment_form_hidden = false


  # здесь описаны екшены которые срабатывают автоматически при  
  def index

    if params.has_key? :search
      @search = params[:search]
      @articles = Article.where("lower(title) like ?", "%#{@search.downcase}%")
      if @articles.size < 1 
        @articles = Article.where("lower(text) like ?", "%#{@search.downcase}%")
      end
    else
        @articles = Article.all
      end
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
     @user_id = params[:article][:user_id]

     @article = Article.new(article_params )
     @article.user_id = @user_id

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

    @article = Article.find(params[:id])

    if  @article.errors.present?
      throw(:abort) 
    else
      @article.destroy
      redirect_to articles_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
