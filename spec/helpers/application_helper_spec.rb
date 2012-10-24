require 'spec_helper'

describe ApplicationHelper do
  describe "show price" do
    it "should always display two decimal places" do
      show_price(10).should == '10.00'
      show_price(0).should == '0.00'
      show_price(1.0).should == '1.00'
      show_price(2.548124).should == '2.55'
      show_price(45.332).should == '45.33'
    end
  end
end
