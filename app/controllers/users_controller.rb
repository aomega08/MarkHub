class UsersController < ApplicationController
  before_action :ensure_not_authenticated

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      authentication.signin(@user)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
