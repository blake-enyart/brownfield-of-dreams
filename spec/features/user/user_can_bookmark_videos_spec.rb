require 'rails_helper'

describe 'As a registered user' do
  context 'when they bookmark a video' do
    it 'dashboard shows videos organized by which tutorial they are a part of' do
      user = create(:user)
      tutorial = create(:tutorial)
      video_1 = tutorial.videos.create(build(:video).attributes)
      video_2 = tutorial.videos.create(build(:video).attributes)
      video_3 = tutorial.videos.create(build(:video).attributes)

      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user)

      visit tutorial_path(tutorial.id, video_id: video_1.id)
      click_on 'Bookmark'

      expect(current_path).to eq(tutorial_path(tutorial))

      visit tutorial_path(tutorial.id, video_id: video_2.id)
      click_on 'Bookmark'

      expect(current_path).to eq(tutorial_path(tutorial))

      visit dashboard_path

      within('.bookmark-videos') do
        expect(page).to have_css('.bookmark-tutorial .bookmark-video a', count: 1)
      end
    end
  end
end
