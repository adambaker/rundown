class UsersController < ApplicationController

  before_filter :authenticate, except: :create

  def show
  end

  def create
    user = User.new params[:user]

    respond_to do |format|
      if user.save
        format.html { redirect_to '/', notice: 'New user account created' }
      else
        format.html do
          flash[:error] = 'Could not create a new account'
          redirect_to '/'
        end
      end
    end
  end

end
