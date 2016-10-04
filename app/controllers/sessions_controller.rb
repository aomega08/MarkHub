class SessionsController < ApplicationController
  before_action :ensure_not_authenticated, except: :destroy

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      authentication.signin(user)
      redirect_to signin_redirect
    else
      flash.now[:error] = 'Invalid email or password!'
      render :new
    end
  end

  def destroy
    authentication.signout
    redirect_to signin_path
  end
end
