class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper


  private

  def loged_in
      redirect_to login_path if !signed_in?
  end  
end
