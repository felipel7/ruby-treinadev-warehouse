require "rails_helper"

describe "Supplier form" do
  it "should redirects user to create a new supplier when clicked" do
    visit root_path
    click_on "Fornecedores"
    click_on "Cadastrar novo fornecedor"

    expect(page).to have_field("Nome fantasia")
    expect(page).to have_field("Razão social")
    expect(page).to have_field("CNPJ")
    expect(page).to have_field("Endereço")
    expect(page).to have_field("Cidade")
    expect(page).to have_field("Estado")
    expect(page).to have_field("E-mail")
  end

  it "should submits the form successfully" do
    visit root_path
    click_on "Fornecedores"
    click_on "Cadastrar novo fornecedor"
    fill_in "Razão social", with: "ACME"
    fill_in "Nome fantasia", with: "ACME Corporation"
    fill_in "CNPJ", with: "22.222.222/2222-2"
    fill_in "Endereço", with: "123 Main St"
    fill_in "Cidade", with: "Curitiba"
    fill_in "Estado", with: "PR"
    fill_in "E-mail", with: "example@acme.com"
    click_on "Enviar"

    expect(page).to have_content "ACME"
    expect(page).to have_content "Curitiba"
    expect(page).to have_content "PR"
  end

  it "should not be able to register a new supplier if any field is empty" do
    visit root_path
    click_on "Fornecedores"
    click_on "Cadastrar novo fornecedor"
    fill_in "Nome fantasia", with: ""
    fill_in "Razão social", with: ""
    fill_in "CNPJ", with: ""
    fill_in "Endereço", with: ""
    fill_in "Cidade", with: ""
    fill_in "Estado", with: ""
    fill_in "E-mail", with: ""
    click_on "Enviar"

    expect(page).to have_content "Fornecedor não cadastrado"
    expect(page).to have_content "Razão social não pode ficar em branco"
    expect(page).to have_content "Nome fantasia não pode ficar em branco"
    expect(page).to have_content "CNPJ não pode ficar em branco"
    expect(page).to have_content "Endereço não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Estado não pode ficar em branco"
    expect(page).to have_content "E-mail não pode ficar em branco"
  end
end
