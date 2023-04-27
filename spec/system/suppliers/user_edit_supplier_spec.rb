require "rails_helper"

describe "Supplier edit" do
  it "should display form when clicked" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    supplier = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    visit root_path
    login_as(user)
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Editar"

    expect(page).to have_field("Razão social", with: "ACME")
    expect(page).to have_field("Nome fantasia", with: "ACME Corporation")
    expect(page).to have_field("CNPJ", with: "22.222.222/2222-2")
    expect(page).to have_field("Endereço", with: "Av. Main Street, 123")
    expect(page).to have_field("Cidade", with: "Curitiba")
    expect(page).to have_field("Estado", with: "PR")
    expect(page).to have_field("E-mail", with: "example@acme.com")
  end

  it "should successfully update the supplier information" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    supplier = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    visit root_path
    login_as(user)
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
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    supplier = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    visit root_path
    login_as(user)
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
