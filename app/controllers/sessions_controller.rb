class SessionsController < ApplicationController

  def home
    respond_to :html
  end

  def index
    respond_to do |format|
      if signed_in?
        format.json { head :no_content }
      else
        format.json { render :json => 'You are not loged in', status: :unprocessable_entity }
      end
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html { render partial: 'login' }
    end
  end

  def create
    user = User.find_by_email(params[:user][:email])

    respond_to do |format|
      if user && user.authenticate(params[:user][:password])
        sign_in user
        format.json { head :no_content }
      else
        format.json { render :json => 'Wrong email or password', status: :unprocessable_entity }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end