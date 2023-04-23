require "rails_helper"

describe "Suppliers view" do
  it "should redirect to suppliers page when clicked" do
    visit root_path
    within "nav" do
      click_on "Fornecedores"
    end

    expect(current_path).to eq suppliers_path
  end

  it "should create and display new suppliers" do
    first_supplier = Supplier.create!(
      corporate_name: "ACME LTDA",
      brand_name: "ACME",
      registration_number: "3333333333333",
      full_address: "Av das Palmas, 100",
      city: "Bauru",
      state: "SP",
      email: "contato@gmail.com",
    )

    second_supplier = Supplier.create!(
      corporate_name: "Spark Industries Brasil LTDA",
      brand_name: "Spark",
      registration_number: "4444433333333",
      full_address: "Av Torres, 200",
      city: "Teresina",
      state: "PI",
      email: "example@gmail.com",
    )

    visit root_path
    click_on "Fornecedores"

    expect(page).to have_content "ACME"
    expect(page).to have_content "Spark"
    expect(page).to have_content "Bauru"
    expect(page).to have_content "Teresina"
  end

  it "should display a default message when there are no suppliers" do
    visit root_path
    click_on "Fornecedores"

    expect(page).to have_content "Não existem fornecedores cadastrados."
  end
end
