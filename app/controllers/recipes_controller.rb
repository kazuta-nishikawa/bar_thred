class RecipesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]
  before_action :correct_user, only:[:edit,:destroy]
  
  def index
    if params[:base]
      @recipes = Recipe.where(base: params[:base])
    elsif params[:technique]
      @recipes = Recipe.where(technique: params[:technique])
    else
      @recipes =  Recipe.order(id: :desc).page(params[:page]).per(25)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @posts = Post.where(recipe_id:params[:id])
    @post = Post.new
  end

  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:success] = '正常に投稿されました'
      redirect_to recipe_path(@recipe)
    else
      flash.now[:danger] = '投稿されませんでした。'
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = '正常に更新されました'
      redirect_to @recipe
    else
      flash.now[:danger] = '更新されませんでした。'
      render :edit
    end
  end
  
  def destroy
    @recipe = Recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title,:body,:image,:base,:technique)
    end
    
    def correct_user
      @recipe = current_user.recipes.find_by(id: params[:id])
      unless @recipe
        redirect_to root_url, alert:"不正なアクセスです。"
      end
    end
    
end
