class PostsController < ApplicationController
  before_action :post_find, only: [:show, :edit, :update]
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(50)
  end 
  
  def show
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
      redirect_to @post
    else 
      flash[:danger] = '書籍の内容の編集に失敗しました。'
      render :edit
    end 
  end 
  
  def destroy
    @post.destroy
    flash[:success] = '書籍の投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end 
  
  private
  
  def post_find
    @post = Post.find(params[:id])
  end 
  
  def post_params
    params.require(:post).permit(:image, :title, :content)
  end 
  
  def correct_user
    unless @post
      redirect_to root_url
    end 
  end 
end
