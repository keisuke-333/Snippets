class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user
  before_action :set_cache_headers

  PER_PAGE = 5

  def show
    @posts = @user.posts.includes(:user, :favorites).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def favorites
    @posts = @user.favorite_posts.includes(:user, :favorites).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def followings
    @relationships = @user.followings.page(params[:page]).per(PER_PAGE)
  end

  def followers
    @relationships = @user.followers.page(params[:page]).per(PER_PAGE)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-store"
  end
end
