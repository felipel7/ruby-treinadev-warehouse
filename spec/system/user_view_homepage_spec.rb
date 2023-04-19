require "rails_helper"

describe "Home screen" do
  it "should display app name" do
    # Arrange

    # Act
    visit("/")

    # Assert
    expect(page).to have_content("Galpões & Estoque")
  end
end
