class LikesController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    like_count = post.likes.count
    render json: { count: like_count }
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])

    # Crear un nuevo "like" asociado al post
    @like = @post.likes.build(like_params)

    if @like.save
      @post.increment!(:likes_count) # Incrementar el contador de likes del post
      redirect_to @post, notice: "Like creado exitosamente."
    else
      redirect_to @post, alert: "Error al crear el like."
    end
  end

end
