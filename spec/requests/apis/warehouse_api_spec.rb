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
      expect(json_response.keys).not_to include "created_at"
      expect(json_response.keys).not_to include "updated_at"
    end

    it "should fail if warehouse not found" do
      get "/api/v1/warehouses/99999"

      expect(response.status).to eq 404
    end
  end

  context "GET /api/v1/warehouses" do
    it "should return a list of warehouses with success" do
      Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      Warehouse.create!(
        name: "Rio", code: "SDU",
        city: "Rio de janeiro", area: 60_000,
        address: "Av. Main Street, 123", cep: "20000-000",
        description: "Galpão do Rio",
      )

      get "/api/v1/warehouses"
      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      expect(json_response.length).to eq 2
      expect(json_response[0]["code"]).to eq "MCZ"
      expect(json_response[1]["code"]).to eq "SDU"
      # expect(json_response.class).to eq Array
      # expect(json_response.first).to ...
    end

    it "should return empty if there is no warehouse" do
      get "/api/v1/warehouses"
      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      expect(json_response).to eq []
    end
  end
end
