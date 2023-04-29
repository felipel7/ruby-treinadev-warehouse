require "rails_helper"

describe "Stock details" do
  it "should ensure users are able to view stock on warehouse page" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    product_a = ProductModel.create!(
      name: "TV 32",
      weight: 8_000,
      width: 70,
      height: 45,
      depth: 10,
      sku: "TV32-SAMSU-XPTO90",
      supplier: supplier,
    )

    product_b = ProductModel.create!(
      name: "SoundBar 7.1 Surround",
      weight: 3000,
      width: 50,
      height: 15,
      depth: 20,
      sku: "SOU71-SAMSU-NOIZ77",
      supplier: supplier,
    )

    product_c = ProductModel.create!(
      name: "TV 42",
      weight: 2000,
      width: 80,
      height: 35,
      depth: 10,
      sku: "TV42-SAMSU-XPXO20",
      supplier: supplier,
    )

    order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 1.week.from_now,
    )

    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_b) }

    login_as(user)
    visit root_path
    click_on "Maceio"

    within "#stock_products" do
      expect(page).to have_content "Itens em Estoque"
      expect(page).to have_content "3 x TV32-SAMSU-XPTO90"
      expect(page).to have_content "2 x SOU71-SAMSU-NOIZ77"
      expect(page).not_to have_content "TV42-SAMSU-XPXO20"
    end
  end

  it "should be able to remove an item from stock" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    product = ProductModel.create!(
      name: "TV 32",
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

    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product) }

    login_as(user)
    visit root_path
    click_on "Maceio"
    select "TV32-SAMSU-XPTO90", from: "Item para Saída"
    fill_in "Destinatário", with: "Maria Ferreira"
    fill_in "Endereço Destino", with: "Rua das Palmeiras, 100 - Campinas - São Paulo"
    click_on "Confirmar Retirada"

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content "Item retirado com sucesso"
    expect(page).to have_content "1 x TV32-SAMSU-XPTO90"
  end
end
