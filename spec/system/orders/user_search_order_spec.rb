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

    order = Order.create(
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
end
