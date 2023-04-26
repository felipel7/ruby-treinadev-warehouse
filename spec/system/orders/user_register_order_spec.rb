require "rails_helper"

describe "User register an order" do
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

    login_as(user)
    visit root_path
    click_on "Registrar pedido"
    select first_warehouse.name, from: "Galpão Destino"
    select first_supplier.corporate_name, from: "Fornecedor"
    fill_in "Data Prevista", with: "20/12/2022"
    click_on "Gravar"

    expect(page).to have_content "Pedido registrado com sucesso."
    expect(page).to have_content "Galpão Destino: Aeroporto SP"
    expect(page).to have_content "Fornecedor: Samsung"
    expect(page).to have_content "Usuário responsável: Maria <maria@email.com>"
    expect(page).not_to have_content "Galpão Rio de janeiro"
    expect(page).not_to have_content "LG do Brasil LTDA"
  end
end
