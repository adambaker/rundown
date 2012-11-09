require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User, user_attr))
    ActionView::TestCase::TestController.any_instance.stub(
      current_user: @user
    )
  end

  it "renders the edit item form" do
    render
    assert_select "form", :action => users_path(@item), :method => "post" do
      assert_select "input#user_name",  name: "user[name]"
      assert_select "input#user_email", name: "user[email]"
    end
  end
end
