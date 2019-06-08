class Creators::TutorialCreator
  attr_reader :tutorial, :errors

  def initialize(params)
    @params = params
    @errors = []
    @tutorial = nil

  end

  def create
    ActiveRecord::Base.transaction do
      tutorial = Tutorial.new(tutorial_params)
      if tutorial.errors
        errors << tutorial.errors.full_messages.to_sentence
      else
        tutorial.save!
      end
      video = tutorial.videos.new(new_video_params.merge(video_param_updates))
      if video.errors
        errors << video.errors.full_messages.to_sentence
      else
        video.save!
      end
    end
    if errors.empty?
      @tutorial = Tutorial.last
    else
      message
    end
  end

  def message
    unless errors.empty?
      errors.join(' and ')
    else
      "#{tutorial.title} was successfully created!"
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
