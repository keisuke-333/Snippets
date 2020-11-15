require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    subject { user.valid? }

    context "データが条件を満たす時" do
      let(:user) { build(:user) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end

    context "name が空の時" do
      let(:user) { build(:user, name: "") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:name]).to include "を入力してください"
      end
    end

    context "name が31文字以上の時" do
      let(:user) { build(:user, name: "a" * 31) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:name]).to include "は30文字以内で入力してください"
      end
    end

    context "email が空の時" do
      let(:user) { build(:user, email: "") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "を入力してください"
      end
    end

    context "email が101文字以上の時" do
      let(:user) { build(:user, email: "a" * 101) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "は100文字以内で入力してください"
      end
    end

    context "email がすでに存在する時" do
      before { create(:user, email: "test@example.com") }
      let(:user) { build(:user, email: "test@example.com") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "はすでに存在します"
      end
    end

    context "email が アルファベット･英数字 のみの時" do
      let(:user) { build(:user, email: Faker::Lorem.characters(number: 16)) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "は不正な値です"
      end
    end

    context "password が空の時" do
      let(:user) { build(:user, password: "") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:password]).to include "を入力してください"
      end
    end

    context "password が5文字以下の時" do
      let(:user) { build(:user, password: "a" * 5) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:password]).to include "は6文字以上で入力してください"
      end
    end

    context "password_confirmation が空の時" do
      let(:user) { build(:user, password_confirmation: "") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:password_confirmation]).to include "とパスワードの入力が一致しません"
      end
    end

    context "password と password_confirmation が異なる時" do
      let(:user) { build(:user, password: "abcdefg", password_confirmation: "abcdefh") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:password_confirmation]).to include "とパスワードの入力が一致しません"
      end
    end

    context "profile が 201文字以上の時" do
      let(:user) { build(:user, profile: "a" * 201) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:profile]).to include "は200文字以内で入力してください"
      end
    end
  end

  # -------------------------------------------------------

  context "user が削除された時" do
    subject { user.destroy }

    let(:user) { create(:user) }
    before do
      create_list(:post, 2, user: user)
      create(:post)
    end
    it "その user の post も削除される" do
      expect { subject }.to change { user.posts.count }.by(-2)
    end
  end
end
