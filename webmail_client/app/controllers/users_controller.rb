class UsersController < ApplicationController

  include InboxHelper
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google/api_client/auth/installed_app'

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
      @inbox = inbox(@user.uid)
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    # auth = hash of objects returned by google
    auth = request.env["omniauth.auth"]
    # either user is found based upon the provider (in this case google_oauth2) and uid...or...they are created using a User class method
    if user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) 
      session[:auth] = auth
      session[:user_id] = user.id  
      flash[:success] = ["You've successfully signed in!"]
      redirect_to root_path
    else
      user = User.create_with_omniauth(auth)
      session[:user_id] = user.id
      flash[:success] = ["You have successfully signed in! Click on \"Create New Ticket\" to get the help you need."]
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :email, :oauthtoken, :oauth_expires_at, :picture )
  end



  # def auth
  # 	redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/callback',:scope => 'https://www.googleapis.com/auth/userinfo.email',:access_type => "offline")
  # end

  # def client
  # 	client ||= OAuth2::Client.new(ENV["CLIENT_ID"], ENV["CLIENT_SECRET"], {
  # 		:site => 'https://accounts.google.com',
  # 		:authorize_url => "/o/oauth2/auth",
  # 		:token_url => "/o/oauth2/token"
  # 		})
  # end

  # def callback
  #   #Gets the Access Token for the User Signed In and Stores it
  #   access_token = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000/callback')
  #   #Stores all the Information that Google Sends Back In Variable For Later Use
  #   google_profile = access_token.get('https://www.googleapis.com/oauth2/v1/userinfo?alt=json')
  #   #Gets the Info Specifically About the signed in User
  #   user_info = JSON.parse(google_profile.body)
  #   emails = JSON.parse(google_profile.body)
  #   #Using the Information Google Sent Back Look for or create the User
  #   @user = User.find_or_create_by(email: user_info["email"])
  #   @user.update(name: user_info["name"] , email: user_info["email"], photo: user_info["picture"], oauthtoken: access_token.token, oauthrefresh: access_token.refresh_token)
  #   #Assign the User a Session
  #   session[:user_id] = @user.id
  #   redirect_to '/'
  # end

end
