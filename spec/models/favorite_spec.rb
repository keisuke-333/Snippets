require "rails_helper"

RSpec.describe Favorite, type: :model do
  describe "バリデーション" do
    subject { favorite.valid? }

    context "データが条件を満たす時" do
      let(:favorite) { create(:favorite) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end

    context "user_id が空の時" do
      let(:favorite) { build(:favorite, user_id: nil) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(favorite.errors.messages[:user_id]).to include "を入力してください"
      end
    end

    context "post_id が空の時" do
      let(:favorite) { build(:favorite, post_id: nil) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(favorite.errors.messages[:post_id]).to include "を入力してください"
      end
    end
  end
end
