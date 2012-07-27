class UsersController < ApplicationController
  include SessionsHelper

  respond_to :js

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
    end
  end

end
