class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    # require "pry"; binding.pry
    @tutorial = Creators::TutorialCreator.new(params)
    if @tutorial.save
      redirect_to tutorial_path(@tutorial)
    else
      flash[:error] = @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

    def tutorial_params
      params.require(:tutorial).permit(:tag_list, :title, :description,
                                       :thumbnail, :playlist_id)
    end
end
