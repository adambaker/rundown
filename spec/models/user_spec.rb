require 'spec_helper'

describe User::Email do
  after :each do
    User::Email.delete_all
  end

  it 'should accept a valid email' do
    User::Email.create! email: 'fake@phony.lie'
  end

  it 'should reject a blank email' do
    User::Email.new( email: '').should_not be_valid
  end

  it 'should require email to be unique' do
    User::Email.create! email: 'fake@phony.lie'
    User::Email.new( email: 'fake@phony.lie').should_not be_valid
  end
end

describe User do
  before :all do
    User::Email.create! email: 'fake@phony.lie'
  end

  before :each do
    @attr = {
      provider: 'goo',
      uid: '123450',
      name: 'somebody',
      email: 'fake@phony.lie',
    }
  end

  it "should accept a valid user" do
    User.create! @attr
  end

end
