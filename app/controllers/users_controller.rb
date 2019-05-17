class UsersController < ApplicationController
  def show
    render locals: {
      facade: SearchResultsFacade.new(current_token)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      ActivationMailer.activation(current_user).deliver_now
      flash[:success] = "Logged in as #{user.first_name}"
      flash[:alert] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    if params[:status] == 'confirmed'
      user = User.find(params[:id])
      if user.update(status: 'active')
        redirect_to activation_success_path
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end

end
