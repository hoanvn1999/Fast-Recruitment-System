require 'rails_helper'

RSpec.describe "Recruiter::Callings", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/recruiter/callings/show"
      expect(response).to have_http_status(:success)
    end
  end

end
