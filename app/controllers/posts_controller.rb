class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.includes(:comments, :likes).order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @like_count = @post.likes_count
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    # Generar una URL de imagen aleatoria de gatos utilizando la API TheCatAPI
    response = HTTParty.get('https://api.thecatapi.com/v1/images/search?mime_types=jpg,png')
    data = JSON.parse(response.body)
    image_url = data.first['url']

    # Asignar la URL de imagen al nuevo post
    @post.img = image_url

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Nuevo Post creado" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post Actualizado" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post Eliminado" }
      format.json { head :no_content }
    end
  end

  def create_like
      @post = Post.find(params[:id])
      @like = @post.likes.build(user_id: params[:user_id])

      respond_to do |format|
        if @like.save
          # Incrementar el contador de likes en la columna likes_count del post
          @post.increment!(:likes_count)

          format.html { redirect_to post_url(@post), notice: "Nuevo like" }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { redirect_to post_url(@post), alert: "Failed to create like." }
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
