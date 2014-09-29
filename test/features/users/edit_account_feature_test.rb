require 'test_helper'

feature 'Edit Account Feature Test' do

  before do
    @user = FactoryGirl.create(:user, username: '')
    login_as(@user)
  end
end
