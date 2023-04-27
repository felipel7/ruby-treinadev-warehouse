require "rails_helper"

RSpec.describe Order, type: :model do
  describe "#valid?" do
    it "should generate a random value when a new order is created" do
      user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      supplier = Supplier.create!(
        corporate_name: "ACME", brand_name: "ACME Corporation",
        registration_number: "12345678901234",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@acme.com",
      )

      order = Order.new(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: "2023-05-05",
      )

      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it "should require an estimated delivery date" do
      user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      supplier = Supplier.create!(
        corporate_name: "ACME", brand_name: "ACME Corporation",
        registration_number: "12345678901234",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@acme.com",
      )

      order = Order.new(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: "",
      )

      order.valid?
      result = order.errors.include? :estimated_delivery_date
      expect(result).to be true
    end

    it "should ensure estimated delivery not to be in the past" do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?
      result = order.errors.include? :estimated_delivery_date

      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser futura.")
    end

    it "should ensure estimated delivery not to be today" do
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser futura.")
    end

    it "should ensure estimated delivery is tomorrow or later" do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be false
    end

    it "should have a code value" do
      user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      supplier = Supplier.create!(
        corporate_name: "ACME", brand_name: "ACME Corporation",
        registration_number: "12345678901234",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@acme.com",
      )

      order = Order.new(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: "2023-05-05",
      )

      result = order.valid?

      expect(result).to eq true
    end

    it "should ensure the generate value is unique" do
      user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      supplier = Supplier.create!(
        corporate_name: "ACME", brand_name: "ACME Corporation",
        registration_number: "12345678901234",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@acme.com",
      )

      first_order = Order.create!(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: "2023-05-05",
      )

      second_order = Order.new(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: "2023-05-05",
      )

      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end
  end
end
