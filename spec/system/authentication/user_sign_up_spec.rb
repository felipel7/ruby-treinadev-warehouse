require "rails_helper"

describe "User Sign Up" do
  it "should create an account successfully" do
    visit root_path
    within "nav" do
      click_on "Entrar"
    end
    click_on "Criar uma conta"
    fill_in "Nome", with: "Maria"
    fill_in "E-mail", with: "maria@gmail.com"
    fill_in "Senha", with: "123123"
    fill_in "Confirme sua senha", with: "123123"
    click_on "Criar conta"

    within "nav" do
      expect(page).to have_content "maria@gmail.com"
      expect(page).to have_button "Sair"
    end

    expect(page).to have_content "Boas vindas! Você realizou seu registro com sucesso."

    user = User.last
    expect(user.name).to eq "Maria"
  end
end
