require "rails_helper"

describe "Warehouse form" do
  it "should redirects user to create a new form when clicked" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    login_as(user)
    visit root_path
    click_on "Cadastrar Galpão"

    expect(page).to have_field("Nome")
    expect(page).to have_field("Descrição")
    expect(page).to have_field("Código")
    expect(page).to have_field("Endereço")
    expect(page).to have_field("Cidade")
    expect(page).to have_field("CEP")
    expect(page).to have_field("Área")
  end

  it "should submits the form successfully" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    login_as(user)
    visit root_path
    click_on "Cadastrar Galpão"
    fill_in "Nome", with: "Rio de Janeiro"
    fill_in "Descrição", with: "Galpão da zona portuária do Rio"
    fill_in "Código", with: "RIO"
    fill_in "Endereço", with: "Avenida do Museu do Amanhã, 1000"
    fill_in "Cidade", with: "Rio de Janeiro"
    fill_in "CEP", with: "20100-000"
    fill_in "Área", with: "32000"
    click_on "Enviar"

    expect(current_path).to eq root_path
    expect(page).to have_content "Galpão cadastrado com sucesso."
    expect(page).to have_content "Rio de Janeiro"
    expect(page).to have_content "RIO"
    expect(page).to have_content "32.000 m²"
  end

  it "should not be able to register a new warehouse if any field is empty" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    login_as(user)
    visit root_path
    click_on "Cadastrar Galpão"
    fill_in "Nome", with: ""
    fill_in "Descrição", with: ""
    fill_in "Código", with: ""
    fill_in "Endereço", with: ""
    fill_in "Cidade", with: ""
    fill_in "CEP", with: ""
    fill_in "Área", with: ""
    click_on "Enviar"

    expect(page).to have_content "Galpão não cadastrado."
    expect(page).to have_content "Endereço não pode ficar em branco"
    expect(page).to have_content "Área não pode ficar em branco"
    expect(page).to have_content "CEP não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Código não pode ficar em branco"
    expect(page).to have_content "Descrição não pode ficar em branco"
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Código não possui o tamanho esperado (3 caracteres)"
  end

  it "should not be able to register a new warehouse if the name is already in use" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    Warehouse.create!(
      name: "Rio de Janeiro", code: "SDU",
      city: "Rio de janeiro", area: 32_000,
      address: "Avenida do Museu do Amanhã, 1000", cep: "21000-000",
      description: "Galpão da zona portuária do Rio",
    )

    login_as(user)
    visit root_path
    click_on "Cadastrar Galpão"
    fill_in "Nome", with: "Rio de Janeiro"
    fill_in "Descrição", with: "Galpão da zona portuária do Rio"
    fill_in "Código", with: "SDU"
    fill_in "Endereço", with: "Avenida do Museu do Amanhã, 1000"
    fill_in "Cidade", with: "Rio de Janeiro"
    fill_in "CEP", with: "21000-000"
    fill_in "Área", with: "32000"
    click_on "Enviar"

    expect(page).to have_content("Nome já está em uso")
  end

  it "should not be able to register a new warehouse if the CEP format is incorrect" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    login_as(user)
    visit root_path
    click_on "Cadastrar Galpão"
    fill_in "Nome", with: "Rio de Janeiro"
    fill_in "Descrição", with: "Galpão da zona portuária do Rio"
    fill_in "Código", with: "SDU"
    fill_in "Endereço", with: "Avenida do Museu do Amanhã, 1000"
    fill_in "Cidade", with: "Rio de Janeiro"
    fill_in "CEP", with: "210001-000"
    fill_in "Área", with: "32000"
    click_on "Enviar"

    expect(page).to have_content("CEP deve ser neste formato: 00000-000")
  end
end
