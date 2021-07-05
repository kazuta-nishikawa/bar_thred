class PostsController < ApplicationController
  

  
  def create
    @post = Post.new(post_params)
    if user_signed_in?
      if @post.save
        flash[:success] = '正常に投稿されました'
        redirect_to recipe_path(@post.recipe.id)
      else
        flash.now[:danger] = '投稿されませんでした。'
        render :new
      end
    else
      redirect_to new_user_session_path
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id,:recipe_id,:content,:comment_number)
  end
end
