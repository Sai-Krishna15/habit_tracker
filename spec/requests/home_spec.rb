require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    context "when user is not signed in" do
      it "shows the welcome page with sign up link" do
        get root_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Welcome to Consistently")
        expect(response.body).to include("Get Started")
        expect(response.body).to include("Sign In")
        expect(response.body).to include("Sign Up")
      end
    end

    context "when user is signed in" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "shows the welcome page with habits link" do
        get root_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Welcome to Consistently")
        expect(response.body).to include("View My Habits")
        expect(response.body).to include("Sign Out")
      end
    end
  end
end
