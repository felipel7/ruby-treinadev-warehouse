require "rails_helper"

# describe 'Warehouse API', type: :request do
describe "Warehouse API" do
  context "GET /api/v1/warehouses/1" do
    it "should return a warehouse with success" do
      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      get "/api/v1/warehouses/#{warehouse.id}"
      json_response = JSON.parse(response.body)
      # 204 -> no content

      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      # expect(response.body).to include "Maceio"
      expect(json_response["name"]).to include "Maceio"
    end
  end
end
