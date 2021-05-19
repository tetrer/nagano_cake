require 'rails_helper'

RSpec.describe "Public::Orders", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/public/orders/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /confirm" do
    it "returns http success" do
      get "/public/orders/confirm"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /complete" do
    it "returns http success" do
      get "/public/orders/complete"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/public/orders/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/public/orders/show"
      expect(response).to have_http_status(:success)
    end
  end

end
