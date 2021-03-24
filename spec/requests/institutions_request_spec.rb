require 'rails_helper'

RSpec.describe "Institutions", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/institutions/show"
      expect(response).to have_http_status(:success)
    end
  end

end
