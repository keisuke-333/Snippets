class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user

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
    @user = User.find_by(id: params[:id])
    if @user.blank?
      redirect_to posts_url, alert: "エラーが発生しました。表示できません。"
    end
  end
end
