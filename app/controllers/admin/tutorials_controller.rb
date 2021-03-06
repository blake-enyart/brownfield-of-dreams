class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @creator = Creators::TutorialCreator.new(params)
    @tutorial = @creator.create
    # require "pry"; binding.pry
    if @tutorial
      @tutorial = Tutorial.last
      flash[:success] = @creator.message
      redirect_to tutorial_path(@tutorial)
    else
      flash[:error] = @creator.message
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

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description,
                                     :thumbnail, :playlist_id)
  end
end
