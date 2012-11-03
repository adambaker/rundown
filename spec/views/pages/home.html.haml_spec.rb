require 'spec_helper'

describe "pages/home.html.haml" do
  it 'puts the login link with no logged in user' do
    controller.stub!(current_user: nil)
    controller.class.helper_method :current_user
    render
    assert_select 'a', href: '/auth/google_oauth2'
  end
end
