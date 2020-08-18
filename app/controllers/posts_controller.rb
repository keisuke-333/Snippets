class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_url, notice: "投稿しました。"
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_url, notice: "更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, alert: "削除しました。"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :language, :code)
  end
end
