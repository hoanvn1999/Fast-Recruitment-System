require 'rails_helper'

RSpec.describe "Admin::Fields", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin/fields/index"
      expect(response).to have_http_status(:success)
    end
  end

end
