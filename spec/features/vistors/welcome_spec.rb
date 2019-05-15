require 'rails_helper'

describe 'As a guest' do
  it 'when they register for an account' do
    user_info = build(:user)

    visit '/'
    click_on 'Register'

    expect(current_path).to eq('/register')

    fill_in 'email', with: user_info.email
    fill_in 'first_name', with: user_info.first_name
    fill_in 'last_name', with: user_info.last_name
    fill_in 'password', with: user_info.password
    fill_in 'password_confirmation', with: user_info.password
    click_on 'Create Account'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Logged in as #{user_info.first_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end
end
