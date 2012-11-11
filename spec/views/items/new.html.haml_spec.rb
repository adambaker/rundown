require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :name => "MyString",
      :price => 1,
      :quantity => 1
    ).as_new_record)
  end

  it "renders new item form" do
    render

    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_name", name: "item[name]"
      assert_select "input#item_price", name: "item[price]"
      assert_select "input#item_quantity", name: "item[quantity]"
      assert_select('input#item_public_attributes_title',
        name: 'item[public_attributes][title]'
      )
      assert_select('textarea#item_public_attributes_body',
        name: 'item[public_attributes][body]'
      )
    end
  end
end
