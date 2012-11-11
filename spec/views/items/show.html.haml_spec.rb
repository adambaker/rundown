require 'spec_helper'

describe "items/show" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      name: "Fucking Name",
      price: 582.11,
      quantity: 2,
      public_attributes: {
        title: 'super sweet story',
        body: 'I forgot to write a story.',
      },
    ))

    @user = assign(:user, stub_model(User, user_attr))
  end

  it 'renders the edit form when logged in' do
    ActionView::TestCase::TestController.any_instance.stub(
      current_user: @user
    )
    render

    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_name", :name => "item[name]"
      assert_select "input#item_price", :name => "item[price]"
      assert_select "input#item_quantity", :name => "item[quantity]"
      assert_select('input#item_public_attributes_title',
        name: 'item[public_attributes][title]'
      )
      assert_select('textarea#item_public_attributes_body',
        name: 'item[public_attributes][body]'
      )
    end
  end

  it "renders public attributes with no user" do
    ActionView::TestCase::TestController.any_instance.stub(
      current_user: nil
    )
    render

    rendered.should match(/super sweet story/)
    rendered.should match(/forgot to write/)
    rendered.should_not match(/Fucking Name/)
    rendered.should_not match(/582\.11/)
  end
end
