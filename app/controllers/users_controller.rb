class UsersController < ApplicationController
  before_action :user_find, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:edit, :update, :destroy]
  
  def index 
    @users = User.order(id: :desc).page(params[:page]).per(50)
  end 
  
  def show
  end 
  
  def new 
    @user = User.new
  end 
  
  def create
    
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '新規登録できました！'
      redirect_to login_path
    else 
      flash[:danger] = '新規登録に失敗しました。'
      render :new
    end 
  end 
  
  def edit
  end 
  
  def update 
    
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を編集しました。'
      redirect_to @user
    else 
      flash[:danger] = 'ユーザー情報の編集に失敗しました。'
      render :edit
    end 
  end 
  
  def destroy
    @user.destroy
    flash[:success] = '退会しました。'
    redirect_to root_url
  end 
  
  private
  
  def user_find
    @user = User.find(params[:id])
  end 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :profile)
    
  end 
end
