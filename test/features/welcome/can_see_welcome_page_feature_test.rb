require 'test_helper'
require 'uri'

feature 'Users::Can See Welcome Page Feature Test' do

  scenario 'test if JS text is added', js: true do
    visit '/'
    ## SAMPLE SUBDOMAIN SUPPORT
    visit '/'
    u = URI.parse(page.current_url)
    port_number = u.port
    visit "http://app.dev:#{port_number}/"
    page.must_have_content 'Added by JS'
  end
end
