require "rails_helper"

describe "Order form" do
  it "should create the order successfully" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    first_supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "12345678901234",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@samsung.com",
    )

    second_supplier = Supplier.create!(
      corporate_name: "LG", brand_name: "LG do Brasil LTDA",
      registration_number: "12312312312312",
      full_address: "Av. Main Street", city: "Rio de Janeiro",
      state: "RJ", email: "example@lg.com",
    )

    first_warehouse = Warehouse.create(
      name: "Aeroporto SP",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      address: "Avenida do Aeroporto, 1000",
      cep: "15000-000",
      description: "Galpão destinado para cargas internacionais",
    )

    second_warehouse = Warehouse.create(
      name: "Galpão Rio de janeiro",
      code: "SDU",
      city: "Rio de janeiro",
      area: 100_000,
      address: "Avenida do Aeroporto, 2000",
      cep: "21000-000",
      description: "Galpão do Rio de janeiro",
    )

    allow(SecureRandom).to receive(:alphanumeric).and_return("12345678")
    # allow(SecureRandom).to receive(:alphanumeric).with(8).and_return("12345678")
    login_as(user)
    visit root_path
    click_on "Registrar Pedido"
    select "GRU - Aeroporto SP", from: "Galpão Destino"
    select first_supplier.corporate_name, from: "Fornecedor"
    fill_in "Data Prevista", with: "05/05/2023"
    click_on "Gravar"

    expect(page).to have_content "Pedido registrado com sucesso."
    expect(page).to have_content "Pedido - 12345678"
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).to have_content "Fornecedor: Samsung"
    expect(page).to have_content "Usuário responsável: Maria - maria@email.com"
    expect(page).to have_content "Data Prevista de Entrega: 05/05/2023"
    expect(page).not_to have_content "Galpão Rio de janeiro"
    expect(page).not_to have_content "LG do Brasil LTDA"
  end

  it "should only create an order for authenticated users" do
    visit root_path
    click_on "Registrar Pedido"

    expect(current_path).to eq new_user_session_path
  end
end
