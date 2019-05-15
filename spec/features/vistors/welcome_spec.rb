require 'rails_helper'

describe 'As a guest' do
  it 'when they register for an account' do
    user_info = build(:user)

    visit '/'
    click_on 'Register'

    expect(current_path).to eq('/register')

    fill_in 'user[email]', with: user_info.email
    fill_in 'user[first_name]', with: user_info.first_name
    fill_in 'user[last_name]', with: user_info.last_name
    fill_in 'user[password]', with: user_info.password
    fill_in 'user[password_confirmation]', with: user_info.password
    click_on 'Create Account'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Logged in as #{user_info.first_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end
end
