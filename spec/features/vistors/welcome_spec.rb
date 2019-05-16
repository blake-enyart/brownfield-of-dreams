require 'rails_helper'

describe 'As a guest' do
  before(:each) do
    @user = build(:user)

    visit '/'
    click_on 'Register'

    expect(current_path).to eq('/register')

    fill_in 'user[email]', with: @user.email
    fill_in 'user[first_name]', with: @user.first_name
    fill_in 'user[last_name]', with: @user.last_name
    fill_in 'user[password]', with: @user.password
    fill_in 'user[password_confirmation]', with: @user.password
    click_on 'Create Account'
  end

  it 'when they register for an account' do

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Logged in as #{@user.first_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end

  it 'should receive email to activate account' do
    allow_any_instance_of(ApplicationController).to \
      receive(:current_user).and_return(@user)

    expect(@user.status).to eq('Inactive')
    # Will find an email sent to test@example.com
    # and set `current_email`
    open_email(@user.email)

    current_email.click_link 'Visit here to activate your account.'
    @user.reload

    expect(current_path).to eq(activation_success_path)
    expect(page).to have_content("Thank you! Your account is now activated.")

    visit dashboard_path

    within('.status') do
      expect(page).to have_content("Status: Active")
    end
  end
end
