class SessionsController < ApplicationController
  def create
    if current_user
      flash[:error] = "You're already logged in."
      redirect_to '/'
      return
    end

    auth = request.env['omniauth.auth']
    if user = User.where(provider: auth['provider'], uid: auth['uid']).first
      session[:user_id] = user._id
      flash[:notice] = 'logged in as ' + auth['info']['name']
      redirect_to '/'
    else
      redirect_to controller: :users, action: :create, user: {
        provider: auth['provider'],
        uid:      auth['uid'],
        name:     auth['info']['name'],
        email:    auth['info']['email'],
      }
    end
  end

  def destroy
  end
end
