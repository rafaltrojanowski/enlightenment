require 'test_helper'

feature 'Users::Can Add Link Or Note Feature Test' do

  scenario 'user add note', js: true do
    visit '/dashboard'

    page.text.must_include 'Conent Entities List'

    fill_in 'content_entity[content]', with: 'my first note'
    click_button 'Save'

    page.text.must_include 'my first note'
  end

  scenario 'user add link', js: true do
    visit '/dashboard'

    page.text.must_include 'Conent Entities List'

    fill_in 'content_entity[content]', with: 'http://emberjs.com/guides/routing/defining-your-routes/'
    click_button 'Save'

    page.text.must_include 'http://emberjs.com/guides/routing/defining-your-routes/'
  end
end
