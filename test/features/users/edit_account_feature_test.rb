require 'test_helper'

feature 'Edit Account Feature Test' do

  before do
    @user = FactoryGirl.create(:user)
    login_as(@user)
  end

  scenario 'must edit password without typing email' do
    visit edit_user_registration_path

    page.text.must_include 'Edit User'

    fill_in 'Email', with: ''

    fill_in 'Password', with: 'yerbamate'
    fill_in 'Password confirmation', with: 'yerbamate'

    fill_in 'Current password', with: @user.password

    click_button 'Update'

    page.text.must_equal 'You updated your account successfully.'
  end
end
