require 'spec_helper'

describe "users/index" do
  before(:each) do
    @user = stub_model(User,
      user_attr.merge(
        email: 'another@email.com',
        name:  'tellingly original',
        uid:   'auoethu',
      )
    )
    ActionView::TestCase::TestController.any_instance.stub(
      current_user: @user
    )
    assign(:users, [
      stub_model(User, user_attr),
      @user,
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => user_attr[:name], :count => 1
    assert_select "tr>td", :text => user_attr[:email], :count => 1
    assert_select "tr>td", :text => 'tellingly original', :count => 1
    assert_select "tr>td", :text => 'another@email.com', :count => 1
  end
end
