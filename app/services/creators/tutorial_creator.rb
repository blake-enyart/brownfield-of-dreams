class Creators::TutorialCreator
  def initialize(params)
    @params = params
  end

  def create
    ApplicationRecord::Base.transaction do
      tutorial = Tutorial.create!(tutorial_params)
      tutorial.videos.create!(new_video_params)
      begin
        tutorial  = Tutorial.find(params[:tutorial_id])
        thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
        video     = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))

        video.save

        flash[:success] = "Successfully created video."
      rescue # Sorry about this. We should get more specific instead of swallowing all errors.
        flash[:error] = "Unable to create video."
      end
    end
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
