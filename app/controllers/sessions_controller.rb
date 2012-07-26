class SessionsController < ApplicationController  
  protect_from_forgery
  include SessionsHelper

  respond_to :js

  def home
    respond_to :html
  end

  def index
    if signed_in?
      redirect_to projects_path
    else
      redirect_to action: :new
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      sign_in user
    else
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end