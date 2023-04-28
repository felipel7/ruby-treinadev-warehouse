require "rails_helper"

describe "Edit Order" do
  it "should ensure user is authenticated to edit order" do
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

    visit edit_order_path(order.id)

    expect(current_path).to eq new_user_session_path
  end

  it "should edit order successfully" do
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
    click_on "Editar"
    fill_in "Data Prevista de Entrega", with: "12/12/2100"
    select "ACME", from: "Fornecedor"
    click_on "Gravar"

    expect(page).to have_content "Pedido atualizado com sucesso."
    expect(page).to have_content "Fornecedor: ACME"
    expect(page).to have_content "Data Prevista de Entrega: 12/12/2100"
  end

  it "should ensure user is authorized to edit order" do
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

    order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )

    login_as(another_user)
    visit edit_order_path(order.id)

    expect(current_path).to eq root_path
  end
end
