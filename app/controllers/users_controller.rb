class UsersController < ApplicationController
  def create
    user = User.new(params[:user])

    respond_to do |format|
      if user.save
        sign_in user
        format.json { render json: current_user.to_json(only: :email) }
      else
        format.json { render json: user.errors.full_messages, status: :unprocessable_entity }
      end
    end    
  end

end
