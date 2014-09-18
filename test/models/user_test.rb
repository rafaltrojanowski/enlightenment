require 'test_helper'

describe User do
  
  before do
    @user = FactoryGirl.create(:user)
  end

  it 'must be valid' do
    @user.must_be :valid?
  end

  it 'wont be email valid' do
    @user.email = 'asshole'
    @user.wont_be :valid?
  end

  it 'too short password' do
    @user.password = 'abc'
    @user.wont_be :valid?
  end
end
