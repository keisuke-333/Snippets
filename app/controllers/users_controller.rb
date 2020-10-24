class UsersController < ApplicationController
  before_action :set_user

  PER_PAGE = 5

  def show
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def favorites
    @posts = @user.favorite_posts.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
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
end
