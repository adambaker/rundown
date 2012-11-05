class UsersController < ApplicationController
  def create
    respond_to do |format|
      if User.create params[:user]
        format.html { redirect_to '/', notice: 'New user account created' }
      end
    end
  end
end
