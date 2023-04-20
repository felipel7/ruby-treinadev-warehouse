require "rails_helper"

RSpec.describe Warehouse, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#valid?" do
    context "presence" do
      it "should be false when name is empty" do
        warehouse = Warehouse.new(
          name: "", code: "SDU",
          city: "Rio de Janeiro", area: 60_000,
          address: "Av. Main Street", cep: "200000-000",
          description: "Galpão do Rio",
        )

        result = warehouse.valid?

        expect(result).to eq false
      end

      it "should be false when code is empty" do
        warehouse = Warehouse.new(
          name: "Rio", code: "",
          city: "Rio de Janeiro", area: 60_000,
          address: "Av. Main Street", cep: "200000-000",
          description: "Galpão do Rio",
        )

        result = warehouse.valid?

        expect(result).to eq false
      end

      it "should be false when address is empty" do
        warehouse = Warehouse.new(
          name: "Rio", code: "SDU",
          city: "Rio de Janeiro", area: 60_000,
          address: "", cep: "200000-000",
          description: "Galpão do Rio",
        )

        result = warehouse.valid?

        expect(result).to eq false
      end
    end

    it "should pass when all fields are filled out correctly" do
      warehouse = Warehouse.new(
        name: "Rio", code: "SDU",
        city: "Rio de Janeiro", area: 60_000,
        address: "Av. Main Street", cep: "200000-000",
        description: "Galpão do Rio",
      )

      result = warehouse.valid?

      expect(result).to eq true
    end

    it "should be false when code is already in use" do
      # create and save first warehouse to db
      first_warehouse = Warehouse.create(
        name: "Rio", code: "SDU",
        city: "Rio de Janeiro", area: 60_000,
        address: "Av. Main Street", cep: "20000-000",
        description: "Galpão do Rio",
      )

      # create a new first warehouse
      second_warehouse = Warehouse.new(
        name: "Niteroi", code: "SDU",
        city: "Rio de Janeiro", area: 50_000,
        address: "Av. Main Street 2", cep: "30000-000",
        description: "Galpão de Niteroi",
      )

      result = second_warehouse.valid?

      expect(result).to eq false
    end
  end
end
