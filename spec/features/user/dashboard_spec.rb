require 'rails_helper'

context 'As a registered user that connects Github' do
  describe 'when they visit their dashboard' do
    describe 'and in "Github" section' do
      it 'shows 5 of their repos', :vcr do
        user = create(:user)
        token = ENV['GITHUB_API_TOKEN']

        allow_any_instance_of(ApplicationController).to \
          receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to \
          receive(:current_token).and_return(token)

        visit dashboard_path

        expect(page).to have_css('.github', text: 'Github')

        within('.github-repos') do
          expect(page).to have_css('.github-repo', count: 5)
        end
      end

      it 'does not show Github section if user is missing token' do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to \
          receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to \
          receive(:current_token).and_return(nil)

        visit dashboard_path

        expect(page).to_not have_css('.github-repos', text: 'Github')
      end
    end

    describe 'under "Followers" in "Github"' do
      it 'lists all followers with their handles linking to their Github profile', :vcr do
        user = create(:user)
        token = ENV['GITHUB_API_TOKEN']

        allow_any_instance_of(ApplicationController).to \
          receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to \
          receive(:current_token).and_return(token)

        visit dashboard_path

        expect(page).to have_css('.github', text: 'Github')

        within('.github-followers') do
          expect(page).to have_css('a.github-follower')
        end
      end
    end

    describe 'under "Following" in "Github"' do
      it 'lists all users that user is followings with their handles linking to their Github profile', :vcr do
        user = create(:user)
        token = ENV['GITHUB_API_TOKEN']

        allow_any_instance_of(ApplicationController).to \
          receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to \
          receive(:current_token).and_return(token)

        visit dashboard_path

        expect(page).to have_css('.github', text: 'Github')

        within('.github-followings') do
          expect(page).to have_css('a.github-following')
        end
      end
    end
  end
end
