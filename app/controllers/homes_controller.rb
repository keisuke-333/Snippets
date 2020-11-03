class HomesController < ApplicationController
  POSTS_NUM = 5

  def index
    redirect_to posts_url if user_signed_in?
    @posts = Post.includes(:user, :favorites).order(impressions_count: "DESC").limit(POSTS_NUM)
  end
end
