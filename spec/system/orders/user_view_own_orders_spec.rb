require "rails_helper"

describe "Order index view" do
  it "should ensure user is authenticated" do
    visit root_path
    click_on "Meus Pedidos"

    expect(current_path).to eq new_user_session_path
  end

  it "should not be able to show orders from another user" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")
    another_user = User.create!(name: "Felipe", email: "felipe@email.com", password: "123123")

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

    first_order = Order.create!(
      user: user, warehouse: warehouse, status: "pending",
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )

    second_order = Order.create!(
      user: another_user, warehouse: warehouse, status: "delivered",
      supplier: supplier, estimated_delivery_date: 2.day.from_now,
    )

    third_order = Order.create!(
      user: user, warehouse: warehouse, status: "canceled",
      supplier: supplier, estimated_delivery_date: 3.day.from_now,
    )

    login_as(user)
    visit root_path
    click_on "Meus Pedidos"

    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
    expect(page).to have_content "Pendente"
    expect(page).not_to have_content "Entregue"
    expect(page).to have_content "Cancelado"
  end

  it "should see order details" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

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

    order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )

    login_as(user)
    visit root_path
    click_on "Meus Pedidos"
    click_on order.code

    expect(page).to have_content "Detalhes do Pedido"
    expect(page).to have_content order.code
    expect(page).to have_content "Galpão Destino: MCZ - Maceio"
    expect(page).to have_content "Fornecedor: ACME"
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end

  it "should not be able to access orders' details from another user" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")
    another_user = User.create!(name: "Felipe", email: "felipe@email.com", password: "123123")

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

    first_order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )

    second_order = Order.create!(
      user: another_user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 2.day.from_now,
    )

    login_as(user)
    visit order_path(second_order.id)

    expect(current_path).not_to eq order_path(second_order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content "Você não possui acesso a esse pedido."
  end

  it "should displays the name and quantity of each item in the order" do
    supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "22.222.222/2222-3",
      full_address: "Av. Main Street, 111", city: "Curitiba",
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

    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 2.day.from_now,
    )

    OrderItem.create!(
      product_model: product_a,
      order: order,
      quantity: 19,
    )

    OrderItem.create!(
      product_model: product_b,
      order: order,
      quantity: 12,
    )

    login_as(user)
    visit root_path
    click_on "Meus Pedidos"
    click_on order.code

    expect(page).to have_content "Itens do Pedido"
    expect(page).to have_content "19 x Produto A"
    expect(page).to have_content "12 x Produto B"
  end
end
