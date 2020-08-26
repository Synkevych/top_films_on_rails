# frozen_string_literal: true

class CommentsController < ApplicationController

  before_action :set_article
  before_action :find_commentable
  
  def new
     @comment = @commentable.comments.build(user_id: current_user.id)
  end

  def create
     #@article = current_user.articles.find(params[:id])
    @comment = @commentable.comments.create(comment_params)

    flash[:success] = "Your comment was successfully created!"
     redirect_to article_path(@article)
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])

    if @comment.destroy
      flash[:success] = "Comment was successfully deleted!"
    else
      flash[:error] = "Something went wrong, the comment wasn't deleted"
    end
    redirect_to article_path(@article)
  end


  private

  def set_article
     #@article = Article.find(params[:article_id])
    unless params[:article_id].nil?
      @article = Article.find(params[:article_id])
    else
      @article =  Article.all
    end
  end

  def find_commentable
      @commentable = Article.find_by_id(params[:article_id]) if params[:article_id]
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
