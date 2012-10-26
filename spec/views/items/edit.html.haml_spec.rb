require 'spec_helper'

describe "items/edit" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :name => "MyString",
      :price => 1,
      :quantity => 1,
      public_attributes: {title: 'glory', body: 'a glorious body'},
    ))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path(@item), :method => "post" do
      assert_select "input#item_name", :name => "item[name]"
      assert_select "input#item_price", :name => "item[price]"
      assert_select "input#item_quantity", :name => "item[quantity]"
      assert_select 'input#item_public_attributes_title', name: 'item[public_attributes][title]'
      assert_select 'textarea#item_public_attributes_body', name: 'item[public_attributes][body]'
    end
  end
end
