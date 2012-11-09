class UsersController < ApplicationController

  before_filter :authenticate, except: :create

  def index
    @users = User.all
  end

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

  def update
    current_user.update_attributes(
      name:  params[:user][:name],
      email: params[:user][:email],
    )

    respond_to do |format|
      format.html { render :show }
    end
  end

  def destroy
    current_user.destroy
    redirect_to '/', notice: 'User account deleted'
  end
end
