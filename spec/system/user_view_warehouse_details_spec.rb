require "rails_helper"

describe "Warehouse details" do
  it "should display warehouse details" do
    Warehouse.create(
      name: "Aeroporto SP",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      address: "Avenida do Aeroporto, 1000",
      cep: "15000-000",
      description: "Galpão destinado para cargas internacionais",
    )

    visit("/")
    click_on("Aeroporto SP")

    expect(page).to have_content("Galpão GRU")
    expect(page).to have_content("Nome: Aeroporto SP")
    expect(page).to have_content("Cidade: Guarulhos")
    expect(page).to have_content("Área: 100.000 m²")
    expect(page).to have_content("Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000")
    expect(page).to have_content("Galpão destinado para cargas internacionais")
  end

  it "should have a link to redirect to the home page" do
    Warehouse.create(
      name: "Aeroporto SP",
      code: "GRU",
      city: "Guarulhos",
      area: 100_000,
      address: "Avenida do Aeroporto, 1000",
      cep: "15000-000",
      description: "Galpão destinado para cargas internacionais",
    )

    visit("/")
    click_on("Aeroporto SP")
    click_on("Voltar")

    expect(current_path).to eq("/")
  end
end
