# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = true

  def user_attr
    {
      provider: 'goo',
      uid: '123450',
      name: 'somebody',
      email: 'fake@phony.lie',
    }
  end

  def a_user(attr=nil)
    attr ||= user_attr
    User::Email.create email: attr[:email]
    User.create! attr
  end

  def session_for(user)
    {user_id: user._id}
  end

  def login_path
    '/auth/google_oauth2'
  end
end
