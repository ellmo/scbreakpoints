require "rails_helper"

describe "Home" do
  describe "GET /index" do
    context "no params" do
      it "returns http success" do
        get "/"

        expect(response).to have_http_status(:success)
      end
    end

    context "wrong params" do
      it "returns http success" do
        get "/dupa:kupa"

        expect(response).to have_http_status(:success)
      end
    end

    context "slightly wrong params" do
      it "returns http success" do
        get "/ling:protos"

        expect(response).to have_http_status(:success)
      end
    end

    context "proper params" do
      it "returns http success" do
        get "/ling:marine"

        expect(response).to have_http_status(:success)
      end
    end
  end
end
