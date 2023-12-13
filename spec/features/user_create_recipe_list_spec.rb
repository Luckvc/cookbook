require 'rails_helper'

describe 'User can create a list of recipes' do
  it 'from home page' do
    user = User.create!(email: 'user@email.com', password: '123456', role: :user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas Listas'

    expect(page).to have_content "Sem Listas registradas"
    expect(page).to have_button "Criar nova lista"
  end
end