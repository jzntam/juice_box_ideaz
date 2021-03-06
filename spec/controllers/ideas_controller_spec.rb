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
    end # context "with user signed in"
    context "user not signed in" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to new_session_path
      end
    end # context "user not signed in"
  end # End of #index

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
    end # context "with user signed in"
    context "user not signed in" do
      it "redirects to sign in page" do
        get :show, id: idea.id 
        expect(response).to redirect_to new_session_path
      end
    end # context "user not signed in"
  end # End of #show

  describe "#new" do
    context "with user signed in" do
      before {login(user)}
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "sets an instance variable for a new idea" do
        get :new
        expect(assigns(:idea)).to be_a_new(Idea)
      end
    end # context "with user signed in"
    context "user not signed in" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to new_session_path
      end
    end # context "user not signed in"
  end # End of #New

  describe "#Create" do
    context "with user signed in" do
      before { login(user) }
      context "with valid parameters" do
        def valid_request
          post :create, {idea: {title: "Valid Title",
                                description: "Valid Description"}}
        end
        it "instantiates a new variable with params passed in" do
          expect { valid_request }.to change { Idea.count }.by(1)
        end
        it "expects idea creator to be the current_user" do
          valid_request
          expect(idea.user).to eq(user)
        end
        it "redirects to the idea show page" do
          valid_request
          expect(response).to redirect_to(Idea.last)
        end
      end
      context "with invalid parameters" do
        def invalid_request
          post :create, {idea: {title: "Valid Title",
                                description: nil }}
        end
        it "doesn't create a record in the database" do
          expect { invalid_request }.to change { Idea.count }.by(0)
        end
        it "renders back to the new idea template" do
          invalid_request
          expect(response).to render_template(:new)
        end
      end
    end # context "with user signed in"
    context "user not signed in" do
      context "with valid parameters" do
        def valid_request
          post :create, {idea: {title: "Valid Title",
                                description: "Valid Description"}}
        end
        it "redirects to sign in page" do
          valid_request
          expect(response).to redirect_to new_session_path
        end
      end
      context "with invalid parameters" do
        def invalid_request
          post :create, {idea: {title: "Valid Title",
                                description: nil }}
        end
        it "redirects to sign in page" do
          invalid_request
          expect(response).to redirect_to new_session_path
        end
      end
    end # context "user not signed in"
  end # End of #create

  describe "#edit" do
    context "with user signed in" do
      before {login(user)}
      before { get :edit, id: idea.id }
      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
      it "sets an instance variable with the idea whose id is passed" do
        expect(assigns(:idea)).to eq(idea)
      end
    end # context "with user signed in"
    context "user not signed in" do
      it "redirects to sign in page" do
        get :edit, id: idea.id
        expect(response).to redirect_to new_session_path
      end
    end # context "user not signed in"
  end # End of #edit

  describe "#update" do
    def valid_attributes(new_attributes = {})
      attributes_for(:idea).merge(new_attributes)
    end
    context "with user signed in" do
      before { login(user) }
      context "with valid attributes" do
        before do
          patch :update, id: idea.id, idea: valid_attributes(title: "YeeHaw")
        end
        it "sets an instance variable with the idea whose id is passed" do
          expect(assigns(:idea)).to eq(idea)
        end
        it "updates the record in the database" do
          expect(idea.reload.title).to eq("YeeHaw")
        end
        it "redirect_to the idea show page" do
          expect(response).to redirect_to(idea_path(idea))
        end
        it "sets a flash message" do
          expect(flash[:notice]).to be
        end
      end # Valid Attributes
      context "with invalid attributes" do
        before do
          patch :update, id: idea.id, idea: valid_attributes(title: "")
        end
        it "sets an instance variable with the idea whose id is passed" do
          expect(assigns(:idea)).to eq(idea)
        end
        it "doesnt update the record in the database" do
          expect(idea.reload.title).to_not eq("")
        end
        it "renders the edit template" do
          expect(response).to  render_template(:edit)
        end
        it "sets a flash message" do
          expect(flash[:alert]).to be
        end
      end # INValid Attributes
    end # context "with user signed in"
    context "user not signed in" do
      context "with valid attributes" do
        it "redirects to sign in page" do
          patch :update, id: idea.id, idea: valid_attributes(title: "YeeHaw")
          expect(response).to redirect_to new_session_path
        end
      end # valid attributes
      context "with invalid attributes" do
        it "redirects to sign in page" do
          patch :update, id: idea.id, idea: valid_attributes(title: "")
          expect(response).to redirect_to new_session_path
        end
      end # invalid attributes
    end # context "user not signed in"
    context "with non-owner user signed in" do
      before { login(user) }
      it "raises an error" do
        expect do
          patch :update, id: idea.id, idea: attributes_for(:idea_1)
        end.to raise_error
      end
    end # context non-owner signed in
  end # End of #update

  describe "#destroy" do
    context "with user signed in" do
      before { login(user) }
      context "with owner signed in" do
        it "sets an instance variable with the idea whose id is passed" do
          delete :destroy, id: idea.id
          expect(assigns(:idea)).to eq(idea)
        end
        it "reduces the number of campaigns in the database by 1" do
          idea
          expect { delete :destroy, id: idea.id }.to change { Idea.count }.by(-1)
        end
        it "redirects to the campaigns index page" do
          delete :destroy, id: idea.id
          expect(response).to redirect_to ideas_path
        end
        it "sets a flash message" do
          delete :destroy, id: idea.id
          expect(flash[:notice]).to be
        end
      end
      context "with non-owner signed in" do
        it "throws an error" do
          expect { delete :destroy, id: idea_2.id }.to raise_error
        end
      end
    end
    context "with user not signed in" do
      it "redirects to the sign in page" do
        delete :destroy, id: idea.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end # End of #update


end
