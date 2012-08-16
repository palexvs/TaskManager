class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def rescue404
    redirect_to root_path, :notice => "The page you were looking for doesn't exist."
  end

  private

  def loged_in
    redirect_to login_path if !signed_in?
  end  
end
