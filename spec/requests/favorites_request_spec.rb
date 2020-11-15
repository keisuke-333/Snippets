require "rails_helper"

RSpec.describe "Favorites", type: :request do

  # -------------------------------------------------------

  describe "#create" do
    subject { post(post_favorites_path(@post.id), xhr: true) }

    before do
      @user = create(:user)
      @post = create(:post)
    end

    context "ログインしている時" do
      before { sign_in @user }

      it "お気に入りの登録ができる" do
        expect { subject }.to change(Favorite, :count).by(1)
      end
    end

    context "ログインしていない時" do
      it "お気に入りの登録がされない" do
        expect { subject }.not_to change(Favorite, :count)
      end

      it "エラーメッセージが表示される" do
        subject
        expect(response.body).to include "アカウント登録もしくはログインしてください。"
      end
    end
  end

  # -------------------------------------------------------

  describe "#destroy" do
    subject { delete(post_favorites_path(@post.id), xhr: true) }

    before do
      @user = create(:user)
      @post = create(:post)
      create(:favorite, post: @post, user: @user)
    end

    context "ログインしている時" do
      before { sign_in @user }

      it "お気に入りの削除ができる" do
        expect { subject }.to change(Favorite, :count).by(-1)
      end
    end

    context "ログインしていない時" do
      it "お気に入りの削除がされない" do
        expect { subject }.not_to change(Favorite, :count)
      end

      it "エラーメッセージが表示される" do
        subject
        expect(response.body).to include "アカウント登録もしくはログインしてください。"
      end
    end
  end

  # -------------------------------------------------------

end
