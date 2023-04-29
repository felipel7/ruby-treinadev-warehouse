require "rails_helper"

describe "Create a order item" do
  it "should create order successfully" do
    user = User.create!(name: "Felipe", email: "felipe@gmail.com", password: "132123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    supplier = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    product_a = ProductModel.create!(
      name: "Produto A",
      weight: 227,
      width: 7,
      height: 10,
      depth: 10,
      sku: "SGS21ULTRA-BLK",
      supplier: supplier,
    )

    product_b = ProductModel.create!(
      name: "Produto B",
      weight: 2400,
      width: 144,
      height: 83,
      depth: 11,
      sku: "OLED65CX-SRTTV-22",
      supplier: supplier,
    )

    order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )

    login_as(user)
    visit root_path
    click_on "Meus Pedidos"
    click_on order.code
    click_on "Adicionar Item"
    select "Produto A", from: "Produto"
    fill_in "Quantidade", with: "8"
    click_on "Gravar"

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Item adicionado com sucesso"
    expect(page).to have_content "8 x Produto A"
  end

  it "should not be able to view products of other suppliers" do
    user = User.create!(name: "Felipe", email: "felipe@gmail.com", password: "132123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    supplier_a = Supplier.create!(
      corporate_name: "LG", brand_name: "LG Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 113", city: "Rio de Janeiro",
      state: "RJ", email: "example@lg.com",
    )

    supplier_b = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "22.222.222/2222-3",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    product_a = ProductModel.create!(
      name: "Produto A",
      weight: 227,
      width: 7,
      height: 10,
      depth: 10,
      sku: "SGS21ULTRA-BLK",
      supplier: supplier_a,
    )

    product_b = ProductModel.create!(
      name: "Produto B",
      weight: 2400,
      width: 144,
      height: 83,
      depth: 11,
      sku: "OLED65CX-SRTTV-22",
      supplier: supplier_b,
    )

    order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier_a, estimated_delivery_date: 1.day.from_now,
    )

    login_as(user)
    visit root_path
    click_on "Meus Pedidos"
    click_on order.code
    click_on "Adicionar Item"

    expect(page).to have_content "Produto A"
    expect(page).not_to have_content "Produto B"
  end
end
