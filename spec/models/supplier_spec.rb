require "rails_helper"

RSpec.describe Supplier, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#valid?" do
    it "should ensure registration number has exactly 13 digits" do
      first_supplier = Supplier.new(
        corporate_name: "ACME", brand_name: "ACME Corporation",
        registration_number: "22.222.222/2222-22",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@acme.com",
      )

      second_supplier = Supplier.new(
        corporate_name: "LG", brand_name: "LG Corporation",
        registration_number: "22.222.222/2222",
        full_address: "Av. Main Street, 122", city: "Rio de Janeiro",
        state: "RJ", email: "example@lg.com",
      )

      first_supplier.valid?
      second_supplier.valid?
      result_more_than_13 = first_supplier.errors[:registration_number]
      result_less_than_13 = second_supplier.errors[:registration_number]

      expect(result_more_than_13).to include("não possui o tamanho esperado (13 caracteres)")
      expect(result_less_than_13).to include("não possui o tamanho esperado (13 caracteres)")
    end
  end
end
