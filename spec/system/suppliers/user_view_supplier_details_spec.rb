require "rails_helper"

describe "Supplier details" do
  it "should redirect to details page when is clicked" do
    supplier = Supplier.create!(
      corporate_name: "ACME LTDA",
      brand_name: "ACME",
      registration_number: "3333333333333",
      full_address: "Av das Palmas, 100",
      city: "Bauru",
      state: "SP",
      email: "contato@gmail.com",
    )

    visit root_path
    click_on "Fornecedores"
    click_on "ACME"

    expect(page).to have_content "ACME"
    expect(page).to have_content "ACME LTDA"
    expect(page).to have_content "3333333333333"
    expect(page).to have_content "Av das Palmas, 100"
    expect(page).to have_content "Bauru"
    expect(page).to have_content "SP"
    expect(page).to have_content "contato@gmail.com"
  end

  it "should redirect to home page" do
    supplier = Supplier.create!(
      corporate_name: "ACME",
      brand_name: "ACME LTDA",
      registration_number: "333333333333",
      full_address: "Av das Palmas, 100",
      city: "Bauru",
      state: "SP",
      email: "contato@gmail.com",
    )

    visit root_path
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Voltar"
  end
end
