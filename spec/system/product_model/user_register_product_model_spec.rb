require "rails_helper"

describe "Product form submission" do
  it "should successfully submit the form" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    first_supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@samsung.com",
    )

    second_supplier = Supplier.create!(
      corporate_name: "LG", brand_name: "LG do Brasil LTDA",
      registration_number: "22.222.222/2222-3",
      full_address: "Av. Main Street", city: "Rio de Janeiro",
      state: "RJ", email: "example@lg.com",
    )

    login_as(user)
    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    click_on "Cadastrar novo"
    fill_in "Nome", with: "TV 40 polegadas"
    fill_in "Peso", with: 10_000
    fill_in "Altura", with: 60
    fill_in "Largura", with: 90
    fill_in "Profundidade", with: 10
    fill_in "SKU", with: "TV40-SAM-XPTO"
    select "Samsung", from: "Fornecedor"
    click_on "Enviar"

    expect(page).to have_content("Modelo de produto cadastrado com sucesso.")
    expect(page).to have_content("TV 40 polegadas")
    expect(page).to have_content("Fornecedor: Samsung")
    expect(page).to have_content("SKU: TV40-SAM-XPTO")
    expect(page).to have_content("Dimensão: 60cm x 90cm x10cm")
    expect(page).to have_content("Peso: 10000g")
  end

  it "should validate required fields for product registration" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    first_supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@samsung.com",
    )

    second_supplier = Supplier.create!(
      corporate_name: "LG", brand_name: "LG do Brasil LTDA",
      registration_number: "22.222.222/2222-3",
      full_address: "Av. Main Street", city: "Rio de Janeiro",
      state: "RJ", email: "example@lg.com",
    )

    login_as(user)
    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end
    click_on "Cadastrar novo"
    fill_in "Nome", with: ""
    fill_in "Peso", with: ""
    fill_in "SKU", with: ""
    click_on "Enviar"

    expect(page).to have_content "Não foi possível cadastrar o modelo de produto."
  end
end
