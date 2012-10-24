require 'spec_helper'

describe Item do
  before :each do
    @attr = {
      name: 'I heart minimalism',
      price: '$20.50',
      quantity: 4,
      notes: "it's like a poster or something"
    }
  end

  it 'should accept a valid item' do
    Item.new(@attr).should be_valid
  end

  it 'should reject an item with no name' do
    Item.new(@attr.merge({name: ''})).should_not be_valid
  end

  it 'should require a non-negative quantity' do
    Item.new(@attr.merge({quantity: ''})).should_not be_valid
    Item.new(@attr.merge({quantity: '-3'})).should_not be_valid
  end

  it 'should require non-negative price' do
    Item.new(@attr.merge({price: ''})).should_not be_valid
    Item.new(@attr.merge({price: '-3'})).should_not be_valid
  end

  it 'should handle dollars and commas' do
    item = Item.create(@attr.merge({price: '$1,020.50'}))
    item.price.should == 1020.50
  end

  it 'should have desired defaults' do
    i = Item.new
    i.quantity.should == 1
  end
end
