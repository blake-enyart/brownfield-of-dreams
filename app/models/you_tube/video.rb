module YouTube
  class Video
    attr_reader :thumbnail, :title, :description

    def initialize(data = {})
      @thumbnail = data[:items].first[:snippet][:thumbnails][:high][:url]
      @title = data[:items].first[:snippet][:title]
      @description = data[:items].first[:snippet][:description]
    end

    def self.by_id(id)
      new(YoutubeService.new.video_info(id))
    end
  end
end
