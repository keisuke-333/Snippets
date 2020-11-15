require "rails_helper"

RSpec.describe "Users", type: :request do

  # -------------------------------------------------------

  describe "#new" do
    subject { get(new_user_registration_path) }

    context "ログインしている時" do
      let(:user) { create(:user) }
      before { sign_in user }
      it "投稿一覧ページにリダイレクトされる" do
        subject
        expect(response).to redirect_to posts_path
      end
    end

    context "ログインしていない時" do
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # -------------------------------------------------------

  describe "#create" do
    subject { post(user_registration_path, params: params) }

    context "パラメータが正常な時" do
      let(:params) { { user: attributes_for(:user) } }
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(302)
      end

      it "user が保存される" do
        expect { subject }.to change { User.count }.by(1)
      end

      it "投稿一覧ページにリダイレクトされる" do
        subject
        expect(response).to redirect_to posts_path
      end
    end

    context "パラメータが異常な時" do
      let(:params) { { user: attributes_for(:user, :invalid) } }
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end

      it "user が保存されない" do
        expect { subject }.not_to change(User, :count)
      end

      it "新規登録ページがレンダリングされる" do
        subject
        expect(response.body).to include "Snippetsへようこそ！"
      end

      it "エラーメッセージが表示される" do
        subject
        expect(response.body).to include "名前を入力してください"
      end
    end
  end

  # -------------------------------------------------------

  describe "#edit" do
    subject { get(edit_user_registration_path) }

    context "ログインしている時" do
      let(:user) { create(:user) }
      before { sign_in user }
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end

      it "name が表示されている" do
        subject
        expect(response.body).to include user.name
      end

      it "profile が表示されている" do
        subject
        expect(response.body).to include user.profile
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

  describe "#show" do
    subject { get(user_path(user_id)) }

    context "ログイン済みで :idに対応するuser が存在する時" do
      let(:user) { create(:user) }
      let(:user_id) { user.id }
      before { sign_in user }
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "name が表示されている" do
        subject
        expect(response.body).to include user.name
      end

      it "profile が表示されている" do
        subject
        expect(response.body).to include user.profile
      end
    end

    context "ログイン済みで :idに対応するuser が存在しない時" do
      let(:user) { create(:user) }
      let(:user_id) { user.id + 1 }
      before { sign_in user }
      it "投稿一覧画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to posts_url
      end
    end

    context "ログインしていない時" do
      let(:user) { create(:user) }
      let(:user_id) { user.id }
      it "ログイン画面にリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # -------------------------------------------------------

  describe "#update" do
    subject { patch(update_user_registration_path, params: params) }

    let(:user) { create(:user) }
    before { sign_in user }

    context "パラメータが正常な時" do
      let(:params) { { user: attributes_for(:user) } }

      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(302)
      end

      it "name が更新される" do
        origin_name = user.name
        new_name = params[:user][:name]
        expect { subject }.to change { user.reload.name }.from(origin_name).to(new_name)
      end

      it "profile が更新される" do
        origin_profile = user.profile
        new_profile = params[:user][:profile]
        expect { subject }.to change { user.reload.profile }.from(origin_profile).to(new_profile)
      end

      it "ユーザー詳細ページにリダイレクトされる" do
        subject
        expect(response).to redirect_to user_path(user.id)
      end
    end

    context "パラメータが異常な時" do
      let(:params) { { user: attributes_for(:user, :invalid) } }

      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end

      it "name が更新されない" do
        expect { subject }.not_to change(user.reload, :name)
      end

      it "編集ページがレンダリングされる" do
        subject
        expect(response.body).to include "名前を入力してください"
      end
    end
  end

  # -------------------------------------------------------

  describe "#destroy" do
    subject { delete(destroy_user_registration_path) }

    let!(:user) { create(:user) }
    before { sign_in user }

    context "パラメータが正常な時" do
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(302)
      end

      it "ユーザーが削除される" do
        expect { subject }.to change(User, :count).by(-1)
      end

      it "トップページにリダイレクトされる" do
        subject
        expect(response).to redirect_to(root_path)
      end
    end
  end

  # -------------------------------------------------------

end
