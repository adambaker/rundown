require 'spec_helper'

describe UsersController do
  before :all do
    User::Email.create email: 'fake@phony.lie'
  end

  before :each do
    User.delete_all
  end

  describe 'POST create' do
    describe 'with valid attributes' do
      it 'should create a new user' do
        expect do
          post :create, user: user_attr
        end.to change(User, :count).by(1)
      end

      it 'should redirect to root' do
        post :create, user: user_attr
        response.should redirect_to('/')
      end

      it 'should post a notice' do
        post :create, user: user_attr
        flash[:notice].should_not be_nil
      end
    end

    describe 'with invalid attributes' do
      it 'should not create a new user' do
        expect do
          post :create, user: {}
        end.not_to change(User, :count)
      end

      it 'should redirect to root' do
        post :create, user: {}
        response.should redirect_to '/'
      end

      it 'should flash an error message' do
        post :create, user: {}
        flash[:error].should_not be_nil
      end
    end
  end

  describe 'GET show' do
    before :each do
      @user = a_user
    end

    it 'redirects to login when no user is logged in' do
      get :show, {id: @user.to_param}
      response.should redirect_to login_path
    end
  end

  describe 'GET index' do
    before :each do
      @user = a_user
      @another = a_user user_attr.merge(
        email: 'anoether@email.com',
        uid:   12456,
        name:  'morefolk',
      )
    end

    it 'redirects to login when no user is logged in' do
      get :index
      response.should redirect_to login_path
    end

    it 'assigns all users as @users' do
      get :index, {}, session_for(@user)
      assigns(:users).should == User.all
    end
  end

end
