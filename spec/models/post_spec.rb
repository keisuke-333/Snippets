require "rails_helper"

RSpec.describe Post, type: :model do
  describe "バリデーション" do
    subject { post.valid? }

    context "データが条件を満たす時" do
      let(:post) { build(:post) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end

    context "title が空の時" do
      let(:post) { build(:post, title: nil) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(post.errors.messages[:title]).to include "を入力してください"
      end
    end

    context "title が51文字以上の時" do
      let(:post) { build(:post, title: "a" * 51) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(post.errors.messages[:title]).to include "は50文字以内で入力してください"
      end
    end

    context "language が空の時" do
      let(:post) { build(:post, language: nil) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(post.errors.messages[:language]).to include "を入力してください"
      end
    end

    context "code が空の時" do
      let(:post) { build(:post, code: nil) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(post.errors.messages[:code]).to include "を入力してください"
      end
    end
  end
end
