require "rails_helper"

RSpec.describe Relationship, type: :model do
  before do
    @following = create(:user, name: "フォローしてる人")
    @follower = create(:user, name: "フォローされる人")
  end
  describe "バリデーション" do
    subject { relationship.valid? }

    context "データが条件を満たす時" do
      let(:relationship) { Relationship.create(following_id: @following.id, follower_id: @follower.id) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end

    context "following_id が空の時" do
      let(:relationship) { Relationship.create(following_id: nil, follower_id: @follower.id) }
      it "エラーが発生する" do
        expect(subject).to eq false
      end
    end

    context "follower_id が空の時" do
      let(:relationship) { Relationship.create(following_id: @following.id, follower_id: nil) }
      it "エラーが発生する" do
        expect(subject).to eq false
      end
    end
  end
end
