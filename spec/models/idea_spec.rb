require 'rails_helper'

RSpec.describe Idea, type: :model do
  let(:user) { create(:user) }

  def valid_attributes(new_attributes = {})
    attributes = {title: "Title for Idea", description: "Idea Description"}
    attributes.merge(new_attributes)
  end

  describe "Validations" do
    it "requires a title" do
      idea = Idea.new(valid_attributes(title: nil))
      expect(idea).to be_invalid
    end
    it "requires a unique title" do
      Idea.create(valid_attributes(title: "New Title"))
      idea = Idea.new(valid_attributes(title: "New Title"))
      expect(idea).to be_invalid
    end
    it "requires a description" do
      idea = Idea.new(valid_attributes(description: nil))
      expect(idea).to be_invalid
    end
  end

  # describe "Associations", type: :model do
  describe "Associations" do
    it "requires idea to belong to User" do
      idea = Idea.new(valid_attributes(user_id: user.id))
      expect(idea).to belong_to :user 
    end
    it "should have a has many pins association" do 
      should have_many(:comments)
    end
    it "should have a has many pins association" do 
      should have_many(:pins)
    end
    it "should have a has many through association with users_who_pinned" do
      should have_many(:users_who_pinned).through(:pins)
    end
    it "should have a has many shares association" do 
      should have_many(:shares)
    end
    it "should have a has many through association with teams_shared_with" do
      should have_many(:teams_shared_with).through(:shares)
    end
  end

end
