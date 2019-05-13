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

      it 'has link to "Add as a Friend" if follower in db', :vcr do
        token = ENV['GITHUB_API_TOKEN']
        following_array = [{:login=>"danielgavrilov",
                            :id=>1308115,
                            :node_id=>"MDQ6VXNlcjEzMDgxMTU=",
                            :avatar_url=>"https://avatars0.githubusercontent.com/u/1308115?v=4",
                            :gravatar_id=>"",
                            :url=>"https://api.github.com/users/danielgavrilov",
                            :html_url=>"https://github.com/danielgavrilov",
                            :followers_url=>"https://api.github.com/users/danielgavrilov/followers",
                            :following_url=>"https://api.github.com/users/danielgavrilov/following{/other_user}",
                            :gists_url=>"https://api.github.com/users/danielgavrilov/gists{/gist_id}",
                            :starred_url=>"https://api.github.com/users/danielgavrilov/starred{/owner}{/repo}",
                            :subscriptions_url=>"https://api.github.com/users/danielgavrilov/subscriptions",
                            :organizations_url=>"https://api.github.com/users/danielgavrilov/orgs",
                            :repos_url=>"https://api.github.com/users/danielgavrilov/repos",
                            :events_url=>"https://api.github.com/users/danielgavrilov/events{/privacy}",
                            :received_events_url=>"https://api.github.com/users/danielgavrilov/received_events",
                            :type=>"User",
                            :site_admin=>false},
                           {:login=>"mispy",
                            :id=>3055384,
                            :node_id=>"MDQ6VXNlcjMwNTUzODQ=",
                            :avatar_url=>"https://avatars1.githubusercontent.com/u/3055384?v=4",
                            :gravatar_id=>"",
                            :url=>"https://api.github.com/users/mispy",
                            :html_url=>"https://github.com/mispy",
                            :followers_url=>"https://api.github.com/users/mispy/followers",
                            :following_url=>"https://api.github.com/users/mispy/following{/other_user}",
                            :gists_url=>"https://api.github.com/users/mispy/gists{/gist_id}",
                            :starred_url=>"https://api.github.com/users/mispy/starred{/owner}{/repo}",
                            :subscriptions_url=>"https://api.github.com/users/mispy/subscriptions",
                            :organizations_url=>"https://api.github.com/users/mispy/orgs",
                            :repos_url=>"https://api.github.com/users/mispy/repos",
                            :events_url=>"https://api.github.com/users/mispy/events{/privacy}",
                            :received_events_url=>"https://api.github.com/users/mispy/received_events",
                            :type=>"User",
                            :site_admin=>false},
                           {:login=>"bradshawben",
                            :id=>13699936,
                            :node_id=>"MDQ6VXNlcjEzNjk5OTM2",
                            :avatar_url=>"https://avatars0.githubusercontent.com/u/13699936?v=4",
                            :gravatar_id=>"",
                            :url=>"https://api.github.com/users/bradshawben",
                            :html_url=>"https://github.com/bradshawben",
                            :followers_url=>"https://api.github.com/users/bradshawben/followers",
                            :following_url=>"https://api.github.com/users/bradshawben/following{/other_user}",
                            :gists_url=>"https://api.github.com/users/bradshawben/gists{/gist_id}",
                            :starred_url=>"https://api.github.com/users/bradshawben/starred{/owner}{/repo}",
                            :subscriptions_url=>"https://api.github.com/users/bradshawben/subscriptions",
                            :organizations_url=>"https://api.github.com/users/bradshawben/orgs",
                            :repos_url=>"https://api.github.com/users/bradshawben/repos",
                            :events_url=>"https://api.github.com/users/bradshawben/events{/privacy}",
                            :received_events_url=>"https://api.github.com/users/bradshawben/received_events",
                            :type=>"User",
                            :site_admin=>false}]

        github_followers = following_array.map do |raw_user|
          DataParse::GithubUser.new(raw_user)
        end

        user = create(:user)
        future_friend = create(:user, github_uid: following_array[0][:id])

        allow_any_instance_of(ApplicationController).to \
          receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to \
          receive(:current_token).and_return(token)

        allow_any_instance_of(SearchResultsFacade).to \
          receive(:followers).and_return(github_followers)

        allow_any_instance_of(DataParse::GithubUser).to \
          receive(:in_database?).and_return(true)

        visit dashboard_path

        expect(user.friends.count).to eq(0)

        within(first('.github-following')) do
          click_on('Add as Friend')
        end

        expect(user.friends.count).to eq(1)
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
