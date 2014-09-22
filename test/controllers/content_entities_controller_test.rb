require 'test_helper'

describe ContentEntitiesController do

  before do
    @content_entity = FactoryGirl.create(:content_entity)
  end

  it 'must create Note' do
    assert_difference('Note.count') do
      post :create, content_entity: { content: 'my note text' }
    end

    must_redirect_to dashboard_url
  end

  it 'must create Link' do
    assert_difference('Link.count') do
      post :create, content_entity: { content: 'http://wwww.google.com' }
    end

    must_redirect_to dashboard_url
  end
end
