class CategoriesController < ApplicationController
  before_action :category_find, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    
  end 
  
  def new
    @category = Category.new
    @categories = Category.all
  end
  
  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      flash[:success] = 'カテゴリーを追加しました！'
      redirect_to categories_user_path(current_user)
    else 
      flash.now[:danger] = 'カテゴリーの追加に失敗しました。'
      render :new
    end 
  end
  
  def edit 
  end
  
  def update 
    if @category.update(category_params_update)
      flash[:success] = 'カテゴリー名を編集しました！'
      redirect_to @category
    else 
      flash[:danger] = 'カテゴリー名の編集に失敗しました。'
      render :edit
    end 
  end
  
  def destroy
    @category.destroy
    flash[:success] = 'カテゴリーを削除しました。'
    redirect_to categories_user_path(current_user)
  end
  
  def category_find
    @category = Category.find(params[:id])
  end 
  
  def category_params
    params.require(:category).permit(:name).merge(user_id: current_user.id)
  end 
  
  def category_params_update
    params.require(:category).permit(:name)
  end 
  
  def correct_user
    unless current_user.comments
      if logged_in?
        redirect_to user_path(current_user)
      else 
        redirect_to root_url
      end 
    end 
  end 
end
