require "rails_helper"

describe "User Login" do
  it "should authenticate successfully" do
    User.create!(
      email: "felipe@gmail.com",
      password: "123123",
    )

    visit root_path
    within "nav" do
      click_on "Entrar"
    end
    within "form" do
      fill_in "E-mail", with: "felipe@gmail.com"
      fill_in "Senha", with: "123123"
      click_on "Entrar"
    end

    within "nav" do
      expect(page).not_to have_link "Entrar"
      expect(page).to have_button "Sair"
      expect(page).to have_content "felipe@gmail.com"
    end
    expect(page).to have_content "Login efetuado com sucesso."
  end

  it "should logout successfully" do
    User.create!(
      email: "felipe@gmail.com",
      password: "123123",
    )

    visit root_path
    within "nav" do
      click_on "Entrar"
    end
    within "form" do
      fill_in "E-mail", with: "felipe@gmail.com"
      fill_in "Senha", with: "123123"
      click_on "Entrar"
    end
    click_on "Sair"

    within "nav" do
      expect(page).to have_link "Entrar"
      expect(page).not_to have_button "Sair"
      expect(page).not_to have_content "felipe@gmail.com"
    end
  end
end
