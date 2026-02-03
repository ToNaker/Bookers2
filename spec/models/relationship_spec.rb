require "rails_helper"

RSpec.describe Relationship, type: :model do
  let(:follower) { create(:user) }
  let(:followed) { create(:user) }

  it "is valid with follower and followed" do
    relationship = build(:relationship, follower: follower, followed: followed)
    expect(relationship).to be_valid
  end

  it "is invalid without follower" do
    relationship = build(:relationship, follower: nil, followed: followed)
    expect(relationship).not_to be_valid
  end

  it "is invalid without followed" do
    relationship = build(:relationship, follower: follower, followed: nil)
    expect(relationship).not_to be_valid
  end

  it "does not allow duplicate follower-followed pair" do
    create(:relationship, follower: follower, followed: followed)
    dup = build(:relationship, follower: follower, followed: followed)
    expect(dup).not_to be_valid
  end

  it "does not allow self-follow" do
    relationship = build(:relationship, follower: follower, followed: follower)
    expect(relationship).not_to be_valid
  end
end
