require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user)   { create(:user) }
  let(:user_1)   { create(:user) }
  let(:idea)   { create(:idea, user: user) }
  let(:idea_1) { create(:idea, user: user) }
  let(:idea_2) { create(:idea, user: user_1) }

  describe "#index" do

    context "user signed in" do
      before { login(user) }
      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end
      it "assigns an instance variable for all the users created ideas" do
        idea
        idea_1
        get :index
        expect(assigns(:my_ideas)).to eq [idea, idea_1]
        # Test fails when idea_2 is added, good test
      end
      it "assigns an instance variable for all the ideas shared with the user" do
        idea
        idea_1
        idea_2
        get :index
        expect(assigns(:shared_with_me)).to eq(user.shared_ideas)
        # byebug
        # This test passes but needs work, teams
      end
      it "assigns an instance variable for all the users pinned ideas" do
        idea
        idea_1
        idea_2
        get :index
        expect(assigns(:pins)).to eq(user.pins)
        # byebug
        # This test passes but needs work, pins
      end
    end

    context "user not signed in" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to new_session_path
      end
    end

  end

  describe "#show" do

    context "with user signed in" do
      before {login(user)}
      before { get :show, id: idea.id }
      it "renders the show template" do
        expect(response).to render_template(:show)
      end
      it "sets an instance variable with the idea whose id is passed" do
        expect(assigns(:idea)).to eq(idea)
      end
      it "set a instance variable to a new comment" do
        expect(assigns(:comment)).to be_a_new Comment
      end
      it "set a instance variable to a new share" do
        expect(assigns(:share)).to be_a_new Share
      end
    end

    context "user not signed in" do
      it "redirects to sign in page" do
        get :show, id: idea.id 
        expect(response).to redirect_to new_session_path
      end
    end
    
  end

end
