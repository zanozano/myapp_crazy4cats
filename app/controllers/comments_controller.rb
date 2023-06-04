class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = "Anónimo" if @comment.user.blank?
    if @comment.save
      redirect_to @post, notice: "Comentario creado exitosamente."
    else
      # Handle error case
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user, :content)
  end
end
