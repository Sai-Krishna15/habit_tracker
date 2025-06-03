require 'rails_helper'

RSpec.describe "HabitCheckins", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/habit_checkins/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/habit_checkins/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
