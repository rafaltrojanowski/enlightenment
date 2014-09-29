require 'test_helper'

feature 'Edit Account Feature Test' do

  before do
    @user = FactoryGirl.create(:user, username: '')
    login_as(@user)
  end

  scenario 'can edit password email and username' do
    visit edit_user_registration_path

    page.text.must_include 'Edit User'

    fill_in 'Email', with: 'yerba@mate.com'
    fill_in 'Username', with: 'pajarito'

    fill_in 'Current password', with: @user.password

    click_button 'Update'

    page.text.must_include 'You updated your account successfully.'
    @user.reload.email.must_equal 'yerba@mate.com'
    @user.reload.username.must_equal 'pajarito'
  end
end
