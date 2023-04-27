require "rails_helper"

describe "Suppliers view" do
  it "should redirect to suppliers page when clicked" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    visit root_path
    login_as(user)
    within "nav" do
      click_on "Fornecedores"
    end

    expect(current_path).to eq suppliers_path
  end

  it "should create and display new suppliers" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    first_supplier = Supplier.create!(
      corporate_name: "ACME",
      brand_name: "ACME LTDA",
      registration_number: "22.222.222/2222-2",
      full_address: "Av das Palmas, 100",
      city: "Bauru",
      state: "SP",
      email: "contato@gmail.com",
    )

    second_supplier = Supplier.create!(
      corporate_name: "Spark",
      brand_name: "Spark Industries Brasil LTDA",
      registration_number: "22.222.222/2222-3",
      full_address: "Av Torres, 200",
      city: "Teresina",
      state: "PI",
      email: "example@gmail.com",
    )

    visit root_path
    login_as(user)
    click_on "Fornecedores"

    expect(page).to have_content "ACME"
    expect(page).to have_content "Spark"
    expect(page).to have_content "Bauru"
    expect(page).to have_content "Teresina"
  end

  it "should display a default message when there are no suppliers" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    visit root_path
    login_as(user)
    click_on "Fornecedores"

    expect(page).to have_content "Não existem fornecedores cadastrados."
  end
end
