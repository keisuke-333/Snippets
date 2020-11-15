require "rails_helper"

RSpec.describe "Posts", type: :request do

  # -------------------------------------------------------

  describe "#index" do
    subject { get(posts_path) }

    context "ログインしている時" do
      let(:user) { create(:user) }
      before { sign_in user }
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context "ログインしていない時" do
      it "ログイン画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # -------------------------------------------------------

  describe "#following" do
    subject { get(following_posts_path) }

    context "ログインしている時" do
      let(:user) { create(:user) }
      before { sign_in user }
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context "ログインしていない時" do
      it "ログイン画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # -------------------------------------------------------

  describe "#new" do
    subject { get(new_post_path) }

    context "ログインしている時" do
      let(:user) { create(:user) }
      before { sign_in user }
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context "ログインしていない時" do
      it "ログイン画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # -------------------------------------------------------

  describe "#create" do
    subject { post(posts_path, params: params) }
    before do
      user = create(:user)
      sign_in user
    end

    context "パラメータが正常な時" do
      let(:params) { { post: attributes_for(:post) } }

      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(302)
      end

      it "post が保存される" do
        expect { subject }.to change(Post, :count).by(1)
      end

      it "投稿詳細画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to post_path(Post.last)
      end
    end

    context "パラメータが異常な時" do
      let(:params) { { post: attributes_for(:post, language: nil) } }

      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end

      it "post が保存されない" do
        expect { subject }.not_to change(Post, :count)
      end

      it "投稿画面がレンダリングされる" do
        subject
        expect(response.body).to include "登録"
      end

      it "エラーメッセージが表示される" do
        subject
        expect(response.body).to include "言語を入力してください"
      end
    end
  end

  # -------------------------------------------------------

  describe "#edit" do
    subject { get(edit_post_path(post.id)) }

    context "ログインしている時" do
      let(:user) { create(:user) }
      before { sign_in user }

      context "投稿者と訪問者が同じ時" do
        let(:post) { create(:post, user: user) }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "title が表示されている" do
          subject
          expect(response.body).to include post.title
        end

        it "language が表示されている" do
          subject
          expect(response.body).to include post.language
        end

        it "code が表示されている" do
          subject
          expect(response.body).to include post.code
        end

        it "更新ボタンが表示されている" do
          subject
          expect(response.body).to include "更新"
        end
      end

      context "投稿者と訪問者が違う時" do
        let(:post) { create(:post) }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(302)
        end

        it "投稿一覧画面にリダイレクトされる" do
          subject
          expect(response).to redirect_to posts_path
        end

        it "エラーメッセージが表示される" do
          subject
          expect(request.flash[:alert]).to eq "エラーが発生しました。"
        end
      end
    end

    context "ログインしていない時" do
      let(:post) { create(:post) }

      it "ログイン画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # -------------------------------------------------------

  describe "#show" do
    subject { get(post_path(post.id)) }

    context "ログインしている時" do
      let(:user) { create(:user) }
      before { sign_in user }

      context "投稿者と訪問者が同じ時" do
        let(:post) { create(:post, user: user) }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "title が表示されている" do
          subject
          expect(response.body).to include post.title
        end

        it "code が表示されている" do
          subject
          expect(response.body).to include post.code
        end

        it "編集ボタンが表示されている" do
          subject
          expect(response.body).to include "編集"
        end

        it "編集ボタンが表示されている" do
          subject
          expect(response.body).to include "削除"
        end
      end

      context "投稿者と訪問者が違う時" do
        let(:post) { create(:post) }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "title が表示されている" do
          subject
          expect(response.body).to include post.title
        end

        it "code が表示されている" do
          subject
          expect(response.body).to include post.code
        end

        it "編集ボタンが表示されていない" do
          subject
          expect(response.body).to exclude "編集"
        end

        it "編集ボタンが表示されていない" do
          subject
          expect(response.body).to exclude "削除"
        end
      end
    end
  end

  # -------------------------------------------------------

  describe "#update" do
    subject { patch(post_path(post_id), params: params) }

    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context "ログインしている時" do
      before { sign_in user }

      context "自分の投稿を編集しようとした時" do
        let(:post) { create(:post, user: user) }
        let(:post_id) { post.id }

        context "パラメータが正常な時" do
          let(:params) { { post: attributes_for(:post, language: "CSS") } }

          it "リクエストが成功する" do
            subject
            expect(response).to have_http_status(302)
          end

          it "title が更新される" do
            origin_title = post.title
            new_title = params[:post][:title]
            expect { subject }.to change { post.reload.title }.from(origin_title).to(new_title)
          end

          it "language が更新される" do
            origin_language = post.language
            new_language = params[:post][:language]
            expect { subject }.to change { post.reload.language }.from(origin_language).to(new_language)
          end

          it "code が更新される" do
            origin_code = post.code
            new_code = params[:post][:code]
            expect { subject }.to change { post.reload.code }.from(origin_code).to(new_code)
          end

          it "投稿詳細画面にリダイレクトされる" do
            subject
            expect(response).to redirect_to post_path(post_id)
          end
        end

        context "パラメーターが異常な時" do
          let(:params) { { post: attributes_for(:post, language: nil) } }

          it "リクエストが成功する" do
            subject
            expect(response).to have_http_status(200)
          end

          it "language が更新されない" do
            expect { subject }.not_to change(post.reload, :language)
          end

          it "編集ページがレンダリングされる" do
            subject
            expect(response.body).to include "言語を入力してください"
          end
        end
      end

      context "他人の投稿を編集しようとした時" do
        let(:post) { create(:post, user: other_user) }
        let(:post_id) { post.id }
        let(:params) { { post: attributes_for(:post, language: "Ruby") } }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(302)
        end

        it "投稿が編集されない" do
          expect { subject }.not_to change(post.reload, :language)
        end

        it "投稿一覧画面にリダイレクトされる" do
          subject
          expect(response).to redirect_to(posts_path)
        end

        it "エラーメッセージが表示される" do
          subject
          expect(request.flash[:alert]).to eq "エラーが発生しました。"
        end
      end
    end

    context "ログインしていない時" do
      let(:post) { create(:post, user: user) }
      let(:post_id) { post.id }
      let(:params) { { post: attributes_for(:post) } }
      it "ログイン画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # -------------------------------------------------------

  describe "#destroy" do
    subject { delete(post_path(post_id)) }

    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context "ログインしている時" do
      before { sign_in user }

      context "自分の投稿を削除しようとした時" do
        let!(:post) { create(:post, user: user) }
        let(:post_id) { post.id }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(302)
        end

        it "投稿が削除される" do
          expect { subject }.to change(Post, :count).by(-1)
        end

        it "投稿一覧画面にリダイレクトされる" do
          subject
          expect(response).to redirect_to(posts_path)
        end
      end

      context "他人の投稿を削除しようとした時" do
        let!(:post) { create(:post, user: other_user) }
        let(:post_id) { post.id }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(302)
        end

        it "投稿が削除されない" do
          expect { subject }.not_to change(Post, :count)
        end

        it "投稿一覧画面にリダイレクトされる" do
          subject
          expect(response).to redirect_to(posts_path)
        end

        it "エラーメッセージが表示される" do
          subject
          expect(request.flash[:alert]).to eq "エラーが発生しました。"
        end
      end
    end

    context "ログインしていない時" do
      let!(:post) { create(:post, user: user) }
      let(:post_id) { post.id }
      it "ログイン画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # -------------------------------------------------------

end
