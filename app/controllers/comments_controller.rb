class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if user_signed_in? && @comment.user.blank?
      @comment.user = current_user.email
    end

    if @comment.save
      redirect_to @post, notice: "Comentario creado exitosamente."
    else
      # Manejar el caso de error en el guardado del comentario
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user, :content)
  end
end
