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
  end
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github

end
