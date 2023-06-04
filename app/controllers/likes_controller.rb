class LikesController < ApplicationController
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

  private

  def like_params
    params.require(:like).permit(:user_id)
  end
end
