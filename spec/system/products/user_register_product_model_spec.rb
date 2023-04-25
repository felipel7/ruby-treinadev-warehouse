require "rails_helper"

describe "Product form" do
  it "should submits the form successfully" do
    supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "12345678901234", full_address: "123 Main St",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    visit root_path
    click_on "Modelos de Produtos"
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
end
