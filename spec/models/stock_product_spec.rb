require "rails_helper"

RSpec.describe StockProduct, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "Serial number" do
    it "should be generated when a new Stock Product is created" do
      user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      supplier = Supplier.create!(
        corporate_name: "Samsung", brand_name: "Samsung Corporation",
        registration_number: "12.222.222/2222-2",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@sams.com",
      )

      product = ProductModel.create!(
        name: "TV 32 MODELO 1",
        weight: 8_000,
        width: 70,
        height: 45,
        depth: 10,
        sku: "TV32-SAMSU-XPTO90",
        supplier: supplier,
      )

      order = Order.create!(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: 1.week.from_now,
      )

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length).to eq 20
    end

    it "should ensure that the generated code value cannot be modified" do
      user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      other_warehouse = Warehouse.create!(
        name: "Rio", code: "SDU",
        city: "Rio de Janeiro", area: 20_000,
        address: "Av. Main Street, 123", cep: "21000-000",
        description: "Galpão do Rio",
      )

      supplier = Supplier.create!(
        corporate_name: "Samsung", brand_name: "Samsung Corporation",
        registration_number: "12.222.222/2222-2",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@sams.com",
      )

      product = ProductModel.create!(
        name: "TV 32 MODELO 1",
        weight: 8_000,
        width: 70,
        height: 45,
        depth: 10,
        sku: "TV32-SAMSU-XPTO90",
        supplier: supplier,
      )

      order = Order.create!(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: 1.week.from_now,
      )

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial = stock_product.serial_number
      stock_product.update(warehouse: other_warehouse)

      expect(original_serial).to eq stock_product.serial_number
    end
  end

  describe "#available?" do
    it "should be true if there is no destination" do
      user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      supplier = Supplier.create!(
        corporate_name: "Samsung", brand_name: "Samsung Corporation",
        registration_number: "12.222.222/2222-2",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@sams.com",
      )

      product = ProductModel.create!(
        name: "TV 32 MODELO 1",
        weight: 8_000,
        width: 70,
        height: 45,
        depth: 10,
        sku: "TV32-SAMSU-XPTO90",
        supplier: supplier,
      )

      order = Order.create!(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: 1.week.from_now,
      )

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.available?).to eq true
    end

    it "should be false if there is already a destination" do
      user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

      warehouse = Warehouse.create!(
        name: "Maceio", code: "MCZ",
        city: "Maceio", area: 50_000,
        address: "Av. Main Street", cep: "30000-000",
        description: "Galpão de Maceio",
      )

      supplier = Supplier.create!(
        corporate_name: "Samsung", brand_name: "Samsung Corporation",
        registration_number: "12.222.222/2222-2",
        full_address: "Av. Main Street, 123", city: "Curitiba",
        state: "PR", email: "example@sams.com",
      )

      product = ProductModel.create!(
        name: "TV 32 MODELO 1",
        weight: 8_000,
        width: 70,
        height: 45,
        depth: 10,
        sku: "TV32-SAMSU-XPTO90",
        supplier: supplier,
      )

      order = Order.create!(
        user: user, warehouse: warehouse,
        supplier: supplier, estimated_delivery_date: 1.week.from_now,
      )

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      stock_product.create_stock_product_destination!(
        recipient: "Maria",
        address: "Rua da Maria",
      )

      expect(stock_product.available?).to eq false
    end
  end
end
