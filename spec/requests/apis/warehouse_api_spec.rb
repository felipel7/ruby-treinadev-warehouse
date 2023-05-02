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

    it "should raise an internal error" do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get "/api/v1/warehouses"

      expect(response).to have_http_status(500)
    end
  end

  context "POST /api/v1/warehouses" do
    it "should create a warehouse with success" do
      warehouse_params = { # payload
        warehouse: {
          name: "Maceio",
          code: "MCZ",
          city: "Maceio",
          area: 50_000,
          address: "Av. Main Street", cep: "30000-000",
          description: "Galpão de Maceio",
        },
      }

      post "/api/v1/warehouses", params: warehouse_params
      json_response = JSON.parse(response.body)

      # expect(response.status).to eq 201 # created
      # expect(response).to have_http_status :created
      expect(response).to have_http_status 201
      expect(response.content_type).to include "application/json"
      expect(json_response["name"]).to eq "Maceio"
      expect(json_response["code"]).to eq "MCZ"
      expect(json_response["city"]).to eq "Maceio"
      expect(json_response["description"]).to eq "Galpão de Maceio"
    end

    it "should fail if parameter is empty" do
      warehouse_params = {
        warehouse: {
          name: "Aeroporto Curitiba",
          code: "CWB",
          city: "",
          area: 50_000,
          address: "",
          cep: "",
          description: "",
        },
      }

      post "/api/v1/warehouses", params: warehouse_params

      expect(response).to have_http_status 412
      expect(response.body).not_to include "Nome não pode ficar em branco"
      expect(response.body).not_to include "Código não pode ficar em branco"
      expect(response.body).to include "Cidade não pode ficar em branco"
      expect(response.body).to include "Endereço não pode ficar em branco"
    end

    it "should fail if there is an internal error" do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_params = {
        warehouse: {
          name: "Maceio",
          code: "MCZ",
          city: "Maceio",
          area: 50_000,
          address: "Av. Main Street", cep: "30000-000",
          description: "Galpão de Maceio",
        },
      }

      post "/api/v1/warehouses", params: warehouse_params

      expect(response).to have_http_status 500
    end
  end
end
