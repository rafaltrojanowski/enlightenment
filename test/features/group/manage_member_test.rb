require 'test_helper'

feature 'Manage Members of Group' do

  before do
    user = FactoryGirl.create(:user)
    @group = FactoryGirl.create(:group, owner_id: user.id)
    FactoryGirl.create(:user, email: '1@2.com')
    @group.users << user
    login_as(user)
  end

  # scenario 'add member', js: true do
    # visit group_path(@group)

    # page.fill_in 'token-input-group_user_tokens', with: '1'
    # page.find('#token-input-group_user_tokens').native.send_keys(:Enter)
    # assert page.has_field? 'token-input-group_user_tokens', with: '1@2.com'
    # click_button 'apply changes'

    # page.text.must_include '1@2.com'
  # end

  # scenario 'remove member', js: true do
    # @group.users << FactoryGirl.create(:user, email: 'remove@this.com')
    # visit group_path(@group)

    # page.text.must_include 'remove@this.com'
    # find('.token-input-delete-token').click
    # click_button 'apply changes'
    # page.text.wont_include 'remove@this.com'
  # end
end
