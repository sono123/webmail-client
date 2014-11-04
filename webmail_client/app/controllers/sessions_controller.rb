class SessionsController < ApplicationController

  def destroy
    session.clear
    flash[:error] = "Toodles."
    redirect_to '/'
  end

end