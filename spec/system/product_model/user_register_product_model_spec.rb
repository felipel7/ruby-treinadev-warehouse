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
    expect(page).to have_content("Dimensão: 60cm x 90cm x 10cm")
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
    fill_in "Altura", with: ""
    fill_in "Largura", with: ""
    fill_in "Profundidade", with: ""
    fill_in "SKU", with: ""
    click_on "Enviar"

    expect(page).to have_content "Não foi possível cadastrar o modelo de produto."
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Peso não pode ficar em branco"
    expect(page).to have_content "Largura não pode ficar em branco"
    expect(page).to have_content "Altura não pode ficar em branco"
    expect(page).to have_content "Profundidade não pode ficar em branco"
    expect(page).to have_content "SKU não pode ficar em branco"
  end

  it "should ensure the code is unique" do
    supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    ProductModel.create!(
      name: "TV 32 MODELO 1",
      weight: 8_000,
      width: 70,
      height: 45,
      depth: 10,
      sku: "TV32-SAMSU-XPTO90",
      supplier: supplier,
    )

    second_product_model = ProductModel.new(
      name: "TV 32 MODELO 2",
      weight: 3_000,
      width: 50,
      height: 15,
      depth: 20,
      sku: "TV32-SAMSU-XPTO90",
      supplier: supplier,
    )

    second_product_model.valid?
    result = second_product_model.errors.include? :sku

    expect(result).to be true
    expect(second_product_model.errors[:sku]).to include("já está em uso")
  end
end
