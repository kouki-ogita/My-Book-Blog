class PostsController < ApplicationController
  before_action :post_find_by, only: [:show, :edit, :update, :destroy, :favoriteds]
  before_action :category_find, only: [:new, :create, :edit]
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(20)
  end 
  
  def show
    @user = @post.user
    @comment = Comment.new
    @comments = @post.comments.order(id: :desc)
  end 
  
  def new 
    @post = Post.new
  end 
  
  def create
    @post = current_user.posts.build(post_params)
    
    
    if @post.save
      flash[:success] = '書籍を投稿しました！'
      redirect_to @post
    else 
      flash.now[:danger] = '書籍の投稿に失敗しました。'
      render :new
    end 
  end 
  
  def edit
  end 
  
  def update
    if @post.update(post_params)
      flash[:success] = '書籍の投稿内容を編集しました！'
      redirect_to post_path(@post)
    else 
      flash[:danger] = '書籍の内容の編集に失敗しました。'
      render :edit
    end 
  end 
  
  def destroy
    @post.destroy
    flash[:success] = '書籍の投稿を削除しました。'
    user_path(current_user)
  end 
  
  def favoriteds
    @favoriteds = @post.favoriteds.page(params[:page])
  end 
  
  private
  
  def post_find_by
    @post = Post.find_by(params[:id])
  end 
  
  def post_params
    params.require(:post).permit(:image, :title, :content, :category_id)
  end 
  
  def category_find
    @categories = current_user.categories
  end
  
  def correct_user
    unless current_user == @post.user
      if logged_in?
        redirect_to user_path(current_user)
      else 
        redirect_to root_url
      end 
    end 
  end
  
end
