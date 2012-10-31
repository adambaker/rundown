require 'spec_helper'

describe SessionsController do

  before :each do
    controller.request.env['omniauth.auth'] = {
      'provider' => 'google',
      'uid' => 'something',
      'info' => {'user' => 'someone', 'email' => 'fake@phony.lie'},
    }
  end

  describe 'without a new user' do
    it 'should redirect to user#create' do
      #post :create
      #response.should redirect_to :user => 'create'
    end
  end

end
