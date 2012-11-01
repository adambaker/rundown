require 'spec_helper'

describe SessionsController do

  before :all do
    User::Email.create email: 'fake@phony.lie'
    @attr = {
      email:    'fake@phony.lie',
      name:     'someone',
      uid:      'something',
      provider: 'google',
    }
  end

  before :each do
    controller.request.env['omniauth.auth'] = {
      'provider' => @attr[:provider],
      'uid'      => @attr[:uid],
      'info'     => {'name' => @attr[:name], 'email' => @attr[:email]},
    }
  end

  describe 'without a new user' do
    it 'should redirect to user#create' do
      User.delete_all
      post :create
      response.should redirect_to controller: :users, action: :create, user: @attr
    end
  end

  describe 'with an existing user' do
    before :all do
      @user = User.create @attr
    end
    after :all do
      @user.delete
    end

    it 'should log the user in' do
      post :create
      controller.current_user.should == @user
    end

    it 'should redirect to root' do
      post :create
      response.should redirect_to('/')
    end

    it 'should flash a login message' do
      post :create
      flash[:notice].should_not be_nil
    end

    it 'should flash an error message if user is logged in' do
      session[:user_id] = @user._id
      post :create
      flash[:error].should_not be_nil
    end
  end

end
