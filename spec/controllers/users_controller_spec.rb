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
  end
end
