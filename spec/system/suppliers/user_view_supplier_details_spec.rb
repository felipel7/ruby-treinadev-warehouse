require "rails_helper"

describe "Supplier details" do
  it "should redirect to details page when is clicked" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    supplier = Supplier.create!(
      corporate_name: "ACME LTDA",
      brand_name: "ACME",
      registration_number: "22.222.222/2222-2",
      full_address: "Av das Palmas, 100",
      city: "Bauru",
      state: "SP",
      email: "contato@gmail.com",
    )

    visit root_path
    login_as(user)
    click_on "Fornecedores"
    click_on "ACME"

    expect(page).to have_content "ACME"
    expect(page).to have_content "ACME LTDA"
    expect(page).to have_content "22.222.222/2222-2"
    expect(page).to have_content "Av das Palmas, 100"
    expect(page).to have_content "Bauru"
    expect(page).to have_content "SP"
    expect(page).to have_content "contato@gmail.com"
  end

  it "should redirect to home page" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")

    supplier = Supplier.create!(
      corporate_name: "ACME",
      brand_name: "ACME LTDA",
      registration_number: "22.222.222/2222-2",
      full_address: "Av das Palmas, 100",
      city: "Bauru",
      state: "SP",
      email: "contato@gmail.com",
    )

    visit root_path
    login_as(user)
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Voltar"
  end
end
