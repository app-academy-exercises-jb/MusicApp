class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(session_params[:email], session_params[:password])
    if user
      login!(user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Incorrect username or password"]
      render :new
    end
  end
  
  def new
    @user = User.new
    render :new
  end

  def destroy
    logout!
    redirect_to root_url
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end