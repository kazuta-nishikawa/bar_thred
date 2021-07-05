class ToppagesController < ApplicationController
  def index
    @recipes = Recipe.order(id: :desc).page(params[:page]).per(10)
  end
end
