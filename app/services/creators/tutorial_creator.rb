class Creators::TutorialCreator
  def initialize(params)
    @params = params
  end

  def create
    ActiveRecord::Base.transaction do
      tutorial = Tutorial.create!(tutorial_params)
      video = tutorial.videos.new(new_video_params.merge(video_param_updates))
      video.save!
    end
  end

  def video_param_updates
    video_info = YouTube::Video.by_id(new_video_params[:video_id])
    title = video_info.title
    thumbnail = video_info.thumbnail
    description = video_info.description
    {
      thumbnail: thumbnail,
      title: title,
      description: description
    }
  end

  private

  attr_reader :params

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description,
                                     :thumbnail, :playlist_id)
  end

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end
end
