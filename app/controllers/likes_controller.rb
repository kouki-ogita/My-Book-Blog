class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:favorite_id])
    current_user.favorite(post)
    flash[:success] = 'いいねしました！'
    redirect_to post
  end 
  
  def destroy
    post = Post.find(params[:favorite_id])
    current_user.unfavorite(post)
    flash[:success] = 'いいねを削除しました'
    redirect_to post
  end 
end
