require 'test_helper'

feature 'Add New Group Test' do

  before do
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  # scenario 'add group', js: true do
    # visit '/groups'

    # page.text.must_include 'Group list:'

    # click_link 'New group'
    # fill_in 'group_name', with: 'nerd group'
    # click_button 'Create Group'

    # page.text.must_include 'nerd group'
  # end

  # scenario 'add group with blank name', js: true do
    # visit '/groups'

    # page.text.must_include 'Group list:'

    # click_link 'New group'
    # click_button 'Create Group'

    # page.text.must_include 'be blank'
  # end
end
