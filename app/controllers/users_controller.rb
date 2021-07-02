class UsersController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :correct_user, only:[:edit,:destroy]
  
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報は正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報は更新されませんでした。'
      render :edit
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user == @user
  end
    
end
