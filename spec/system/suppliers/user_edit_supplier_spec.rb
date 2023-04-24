require "rails_helper"

describe "Supplier edit" do
  it "should display form when clicked" do
    supplier = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "12345678901234", full_address: "123 Main St",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    visit root_path
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Editar"

    expect(page).to have_field("Razão social", with: "ACME")
    expect(page).to have_field("Nome fantasia", with: "ACME Corporation")
    expect(page).to have_field("CNPJ", with: "12345678901234")
    expect(page).to have_field("Endereço", with: "Av. Main Street")
    expect(page).to have_field("Cidade", with: "Curitiba")
    expect(page).to have_field("Estado", with: "PR")
    expect(page).to have_field("E-mail", with: "example@acme.com")
  end

  it "should successfully update the supplier information" do
    supplier = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "12345678901234", full_address: "123 Main St",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    visit root_path
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Editar"
    fill_in "Cidade", with: "Rio de Janeiro"
    fill_in "Estado", with: "RJ"
    fill_in "Endereço", with: "Rua Tiradentes, 111"
    fill_in "E-mail", with: "novo@acme.com"
    click_on "Enviar"

    expect(page).to have_content("Rio de Janeiro - RJ")
    expect(page).to have_content("Rua Tiradentes, 111")
    expect(page).to have_content("E-mail: novo@acme.com")
  end

  it "should prevent editing fields with empty values" do
    supplier = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "12345678901234", full_address: "123 Main St",
      full_address: "Av. Main Street", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    visit root_path
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Editar"
    fill_in "Nome fantasia", with: ""
    fill_in "Razão social", with: ""
    fill_in "CNPJ", with: ""
    fill_in "Endereço", with: ""
    fill_in "Cidade", with: ""
    fill_in "Estado", with: ""
    fill_in "E-mail", with: ""
    click_on "Enviar"

    expect(page).to have_content "Não foi possível atualizar o fornecedor."
  end
end
