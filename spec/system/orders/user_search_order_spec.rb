require "rails_helper"

describe "Search order" do
  it "should allow authenticate user to view the search bar" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    login_as(user)
    visit root_path

    within "nav" do
      expect(page).to have_field("Buscar Pedido")
      expect(page).to have_button("Buscar")
    end
  end

  it "should be found when filled correctly" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@samsung.com",
    )

    warehouse = Warehouse.create!(
      name: "Aeroporto SP",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      address: "Avenida do Aeroporto, 1000",
      cep: "15000-000",
      description: "Galpão destinado para cargas internacionais",
    )

    order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )
    login_as(user)
    visit root_path
    fill_in "Buscar Pedido", with: order.code
    click_on "Buscar"

    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content "1 pedido encontrado"
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).to have_content "Fornecedor: Samsung"
  end

  it "should find multiples orders" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@samsung.com",
    )

    first_warehouse = Warehouse.create!(
      name: "Aeroporto SP",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      address: "Avenida do Aeroporto, 1000",
      cep: "15000-000",
      description: "Galpão destinado para cargas internacionais",
    )

    second_warehouse = Warehouse.create!(
      name: "Aeroporto Rio",
      code: "SDU",
      city: "Rio de Janeira",
      area: 100_000,
      address: "Avenida do Aeroporto, 2000",
      cep: "21000-000",
      description: "Galpão destinado para cargas",
    )

    allow(SecureRandom).to receive(:alphanumeric).and_return("GRU45678")
    first_order = Order.create!(
      user: user, warehouse: first_warehouse,
      supplier: supplier, estimated_delivery_date: 2.day.from_now,
    )
    allow(SecureRandom).to receive(:alphanumeric).and_return("GRU87654")
    second_order = Order.create!(
      user: user, warehouse: first_warehouse,
      supplier: supplier, estimated_delivery_date: 2.day.from_now,
    )
    allow(SecureRandom).to receive(:alphanumeric).and_return("SDU45678")
    third_order = Order.create!(
      user: user, warehouse: second_warehouse,
      supplier: supplier, estimated_delivery_date: 2.day.from_now,
    )

    login_as(user)
    visit root_path
    fill_in "Buscar Pedido", with: "GRU"
    click_on "Buscar"

    expect(page).to have_content "2 pedidos encontrados"
    expect(page).to have_content "Resultados da Busca por: GRU"
    expect(page).to have_content "GRU45678"
    expect(page).to have_content "GRU87654"
    expect(page).not_to have_content "SDU45678"
  end
end
