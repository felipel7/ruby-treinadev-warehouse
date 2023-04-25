require "rails_helper"

describe "Product view" do
  it "should redirect to products page when clicked" do
    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq product_models_path
  end

  it "should create and display new products" do
    supplier = Supplier.create!(
      corporate_name: "Samsung", brand_name: "Samsung Corporation",
      registration_number: "12345678901234",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    ProductModel.create!(
      name: "TV 32",
      weight: 8_000,
      width: 70,
      height: 45,
      depth: 10,
      sku: "TV32-SAMSU-XPTO90",
      supplier: supplier,
    )

    ProductModel.create!(
      name: "SoundBar 7.1 Surround",
      weight: 3_000,
      width: 50,
      height: 15,
      depth: 20,
      sku: "SOU71-SAMSU-NOIZ77",
      supplier: supplier,
    )

    visit root_path
    within "nav" do
      click_on "Modelos de Produtos"
    end

    expect(page).to have_content "TV 32"
    expect(page).to have_content "SoundBar 7.1 Surround"
    expect(page).to have_content "Samsung"
    expect(page).to have_content "TV32-SAMSU-XPTO90"
    expect(page).to have_content "SOU71-SAMSU-NOIZ77"
  end

  it "should display a default message when there are no products" do
    visit root_path
    click_on "Modelos de Produtos"

    expect(page).to have_content "Nenhum modelo de produto cadastrado."
  end
end
