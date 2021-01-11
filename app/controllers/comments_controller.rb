class CommentsController < ApplicationController
  before_action :comment_find_by, only: [:edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def create
    @comment = current_user.comments.build(comment_params)
    
    if @comment.save
      flash[:success] = 'コメントを投稿しました！'
      redirect_back(fallback_location: root_path)
    else 
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end 
  end

  def edit
  end

  def update
    if @comment.update(comment_params_update)
      flash[:success] = '投稿したコメントを編集しました！'
      redirect_to post_path(@comment.post)
    else 
      flash[:danger] = '投稿したコメントの編集に失敗しました。'
      render :edit
    end 
  end

  def destroy
    @comment.destroy
    flash[:success] = '投稿したコメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  def comment_find_by
    @comment = Comment.find_by(id: params[:id])
  end 
  
  def comment_params
    params.require(:comment).permit(:remark).merge(user_id: current_user.id, post_id: params[:post_id])
  end 
  
  def comment_params_update
    params.require(:comment).permit(:remark)
  end 
  
  def correct_user
    unless current_user == @comment.user
      if logged_in?
        redirect_to user_path(current_user)
      else 
        redirect_to root_url
      end 
    end 
  end 
end
