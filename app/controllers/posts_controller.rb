class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  PER_PAGE = 10

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post.id), notice: "投稿しました。"
    else
      render :new
    end
  end

  def show
    @user = @post.user
    impressionist(@post, nil, unique: [:session_hash])
  end

  def edit
    if @post.user_id != current_user.id
      redirect_to posts_url, alert: "エラーが発生しました。表示できません。"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(params[:id]), notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "削除しました。"
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    if @post.blank?
      redirect_to posts_url, alert: "エラーが発生しました。表示できません。"
    end
  end

  def post_params
    params.require(:post).permit(:title, :language, :code)
  end

  def search_params
    params.require(:q).permit(:title_or_code_cont)
  end
end
