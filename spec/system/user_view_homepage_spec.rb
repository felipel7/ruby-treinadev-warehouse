require "rails_helper"

describe "Home screen" do
  it "should display app name" do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content("Galpões & Estoque")
  end

  it "should display registered warehouses" do
    Warehouse.create(name: "Rio", code: "SDU", city: "Rio de Janeiro", area: 60_000)
    Warehouse.create(name: "Maceio", code: "MCZ", city: "Maceio", area: 50_000)

    visit root_path

    expect(page).not_to have_content("Não há galpões cadastrados")
    # First warehouse
    expect(page).to have_content("Rio")
    expect(page).to have_content("Código: SDU")
    expect(page).to have_content("Cidade: Rio de Janeiro")
    expect(page).to have_content("60.000 m²")
    # Second warehouse
    expect(page).to have_content("Maceio")
    expect(page).to have_content("Código: MCZ")
    expect(page).to have_content("Cidade: Maceio")
    expect(page).to have_content("50.000 m²")
  end

  it "should display a default message when there are no warehouses" do
    visit root_path

    expect(page).to have_content("Não há galpões cadastrados")
  end
end
