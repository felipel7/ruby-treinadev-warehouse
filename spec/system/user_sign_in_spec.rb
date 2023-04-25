require "rails_helper"

describe "User authentication" do
  it "should authenticate successfully" do
    User.create!(
      email: "felipe@gmail.com",
      password: "123123",
    )

    visit root_path
    click_on "Entrar"
    within "form" do
      fill_in "E-mail", with: "felipe@gmail.com"
      fill_in "Senha", with: "123123"
      click_on "Entrar"
    end

    within "nav" do
      expect(page).to have_link "Sair"
      expect(page).not_to have_link "Entrar"
      expect(page).to have_content "felipe@gmail.com"
    end

    expect(page).to have_content "Login efetuado com sucesso."
  end
end
