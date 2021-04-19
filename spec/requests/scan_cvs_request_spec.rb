require 'rails_helper'

RSpec.describe "ScanCvs", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/scan_cvs/new"
      expect(response).to have_http_status(:success)
    end
  end

end
