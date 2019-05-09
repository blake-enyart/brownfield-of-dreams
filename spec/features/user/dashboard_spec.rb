require 'rails_helper'

context 'As a registered user' do
  describe 'when they visit their dashboard' do
    it 'shows them a Github section with 5 of their repos', :vcr do
      user = create(:user)
      token = ENV['GITHUB_API_TEST_KEY']

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:current_token).and_return(token)

      visit dashboard_path

      expect(page).to have_css('.github-repos', text: 'Github')

      within('.github-repos') do
        expect(page).to have_css('.github-repo', count: 5)
      end
    end

    it 'does not show Github section if user is missing token' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:current_token).and_return(nil)

      visit dashboard_path

      expect(page).to_not have_css('.github-repos', text: 'Github')
    end
  end
end
