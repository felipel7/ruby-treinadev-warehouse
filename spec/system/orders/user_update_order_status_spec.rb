require "rails_helper"

describe "Update order" do
  it "should be able to update status to delivered" do
    user = User.create!(name: "Felipe", email: "felipe@gmail.com", password: "123123")

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
      user: user, warehouse: warehouse, status: :pending,
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )

    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as(user)
    visit root_path
    click_on "Meus Pedidos"
    click_on order.code
    click_on "Marcar como ENTREGUE"

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Situação do Pedido: Entregue"
    expect(page).not_to have_button "Marcar como ENTREGUE"
    expect(page).not_to have_button "Marcar como CANCELADO"
    expect(StockProduct.count).to eq 5
    stock = StockProduct.where(product_model: product, warehouse: warehouse).count
    expect(stock).to eq 5
  end

  it "should be able to update status to be canceled" do
    user = User.create!(name: "Felipe", email: "felipe@gmail.com", password: "123123")

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
      user: user, warehouse: warehouse, status: :pending,
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )

    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as(user)
    visit root_path
    click_on "Meus Pedidos"
    click_on order.code
    click_on "Marcar como CANCELADO"

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Situação do Pedido: Cancelado"
    expect(StockProduct.count).to eq 0
  end
end
