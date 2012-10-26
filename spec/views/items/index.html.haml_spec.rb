require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :name => "Name",
        :price => '1',
        :quantity => 2,
      ),
      stub_model(Item,
        :name => "Name",
        :price => '1.0',
        :quantity => 2,
        :notes => 'notes',
      )
    ])
  end

  it "renders a list of items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name", :count => 2
    assert_select "tr>td", :text => '1.00', :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
