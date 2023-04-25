require "rails_helper"

RSpec.describe ProductModel, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "#valid?" do
    it "name is mandatory" do
      supplier = Supplier.create!(
        corporate_name: "Samsung", brand_name: "Samsung Corporation",
        registration_number: "12345678901234",
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
  end
end
