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
    @user = User.new(user_params)
    if @user.save
      user_activation_process
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    return unless params[:status] == 'confirmed'

    user = User.find(params[:id])
    redirect_to activation_success_path if user.update(status: 'active')
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def user_activation_process
    session[:user_id] = @user.id
    ActivationMailer.activation(current_user).deliver_now
    flash[:success] = "Logged in as #{@user.first_name}"
    flash[:alert] = 'This account has not yet been activated.
      Please check your email.'
  end
end
