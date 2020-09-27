class UsersController < ApplicationController
  before_action :set_user

  def show
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(5)
  end

  def favorites
    @posts = @user.favorite_posts.order(created_at: :desc).page(params[:page]).per(5)
  end

  def followings
    @relationships = @user.followings.page(params[:page]).per(5)
  end

  def followers
    @relationships = @user.followers.page(params[:page]).per(5)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
