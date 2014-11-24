class UsersController < ApplicationController

  def index
  end

  def show
  end

  def create
    # auth = hash of objects returned by google
    auth = request.env["omniauth.auth"]  
    # either user is found based upon the provider (in this case google_oauth2) and uid
    if user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) 
      session[:user_id] = user.id  
      flash[:success] = ["You've successfully signed in!"]
      redirect_to root_path
    else
    # ...or...they are created using a the User class method above
      user = User.create_with_omniauth(auth)
      session[:user_id] = user.id
      flash[:success] = ["You have successfully signed in! Welcome to the site."]
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :email, :oauthtoken, :oauth_expires_at, :avatar)
  end

end
