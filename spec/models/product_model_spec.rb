require "rails_helper"

RSpec.describe ProductModel, type: :model do
  describe "#valid?" do
    it "name is required" do
      supplier = Supplier.create!(
        corporate_name: "Samsung", brand_name: "Samsung Corporation",
        registration_number: "22.222.222/2222-2",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@samsung.com",
      )

      product = ProductModel.new(
        name: "",
        weight: 8_000,
        width: 70,
        height: 45,
        depth: 10,
        sku: "TV32-SAMSU-XPTO90",
        supplier: supplier,
      )

      result = product.valid?

      expect(result).to eq false
    end

    it "should ensure dimensions are greater than zero" do
      supplier = Supplier.create!(
        corporate_name: "Samsung", brand_name: "Samsung Corporation",
        registration_number: "22.222.222/2222-2",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@samsung.com",
      )

      product = ProductModel.new(
        name: "test",
        weight: 0,
        width: -4,
        height: -5,
        depth: 0,
        sku: "TV32-SAMSU-XPTO90",
        supplier: supplier,
      )

      product.valid?
      result = product.errors

      expect(result[:weight]).to include(" deve ser maior que zero.")
      expect(result[:width]).to include(" deve ser maior que zero.")
      expect(result[:height]).to include(" deve ser maior que zero.")
      expect(result[:depth]).to include(" deve ser maior que zero.")
    end
  end
end
