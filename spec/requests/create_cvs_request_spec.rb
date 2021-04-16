require 'rails_helper'

RSpec.describe "CreateCvs", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/create_cvs/new"
      expect(response).to have_http_status(:success)
    end
  end

end
