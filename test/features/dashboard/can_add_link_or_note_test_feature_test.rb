require 'test_helper'

feature 'Users::Can Add Link Or Note Feature Test' do
  before do
    @user = FactoryGirl.create(:user)

  end

  scenario 'must be logged in to add content', js: true do
    visit '/dashboard'

    page.text.must_include 'Welcome guest!'

    page.text.wont_include 'List'
    page.text.wont_include 'Add'
    page.text.wont_include 'Add content'

    # page.body.wont_include 'content_entity[content]' # TODO
  end

  scenario 'user add note', js: true do
    login_as(@user)

    visit '/dashboard'

    page.text.must_include 'List'

    fill_in 'content_entity[content]', with: 'my first note'
    click_button 'Add'

    page.text.must_include 'my first note'
  end

  scenario 'user add link', js: true do
    login_as(@user)
    visit '/dashboard'

    page.text.must_include 'List'

    fill_in 'content_entity[content]', with: 'http://emberjs.com/guides/routing/defining-your-routes/'
    click_button 'Add'

    page.text.must_include 'http://emberjs.com/guides/routing/defining-your-routes/'
  end
end
