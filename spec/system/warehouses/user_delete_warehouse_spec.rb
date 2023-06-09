require "rails_helper"

describe "Delete Warehouse" do
  it "should properly delete registered warehouse" do
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
    click_on "Remover"

    expect(current_path).to eq root_path
    expect(page).to have_content "Galpão removido com sucesso."
    expect(page).not_to have_content "Maceio"
    expect(page).not_to have_content "MCZ"
  end

  it "should not delete all registered warehouses" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    first_warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    second_warehouse = Warehouse.create!(
      name: "Rio", code: "SDU",
      city: "Rio de janeiro", area: 20_000,
      address: "Av. Main Street", cep: "12000-000",
      description: "Galpão do Rio",
    )

    login_as(user)
    visit root_path
    click_on "Maceio"
    click_on "Remover"

    expect(current_path).to eq root_path
    expect(page).to have_content "Galpão removido com sucesso."
    expect(page).not_to have_content "Maceio"
    expect(page).not_to have_content "MCZ"

    expect(page).to have_content "Rio"
    expect(page).to have_content "SDU"
  end
end
