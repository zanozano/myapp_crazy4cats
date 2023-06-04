class LikesController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    like_count = post.likes.count
    render json: { count: like_count }
  end

 
def create
  post = Post.find(params[:post_id])

  # Lógica para crear un nuevo "like" utilizando los parámetros user_id y post_id
  like = Like.new(user_id: params[:user_id], post_id: params[:post_id])

  if like.save
    like_count = post.likes.count

    render json: { count: like_count }
  else
    render json: { error: "Failed to like" }, status: :unprocessable_entity
  end
end



end
