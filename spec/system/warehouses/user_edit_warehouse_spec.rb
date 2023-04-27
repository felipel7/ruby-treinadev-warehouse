require "rails_helper"

describe "Warehouse edit" do
  it "should display details of a warehouse form when clicked" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    login_as(user)
    visit root_path
    click_on "Maceio"
    click_on "Editar"

    expect(page).to have_field("Nome", with: "Maceio")
    expect(page).to have_field("Descrição", with: "Galpão de Maceio")
    expect(page).to have_field("Código", with: "MCZ")
    expect(page).to have_field("Endereço", with: "Av. Main Street")
    expect(page).to have_field("Cidade", with: "Maceio")
    expect(page).to have_field("CEP", with: "30000-000")
    expect(page).to have_field("Área", with: 50_000)
  end

  it "should successfully update the warehouse information" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    login_as(user)
    visit root_path
    click_on "Maceio"
    click_on "Editar"
    fill_in "Nome", with: "Rio de Janeiro"
    fill_in "Descrição", with: "Galpão da zona portuária do Rio"
    fill_in "Código", with: "RIO"
    fill_in "Endereço", with: "Avenida do Museu do Amanhã, 1000"
    fill_in "Cidade", with: "Rio de Janeiro"
    fill_in "CEP", with: "20100-000"
    fill_in "Área", with: "32000"
    click_on "Enviar"

    expect(page).to have_content("Galpão atualizado com sucesso.")
    expect(page).to have_content("Descrição: Galpão da zona portuária do Rio")
    expect(page).to have_content("Código: RIO")
    expect(page).to have_content("Cidade: Rio de Janeiro")
  end

  it "should prevent editing fields with empty values" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    login_as(user)
    visit root_path
    click_on "Maceio"
    click_on "Editar"
    fill_in "Nome", with: ""
    fill_in "Descrição", with: ""
    fill_in "Código", with: ""
    click_on "Enviar"

    expect(page).to have_content("Não foi possível atualizar o galpão.")
  end
end
