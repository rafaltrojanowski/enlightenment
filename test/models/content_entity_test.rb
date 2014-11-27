require "test_helper"
require 'sidekiq/testing'

describe ContentEntity do
  describe 'create' do
    context 'content contains url only' do
      it 'must create content entity and link' do
        cn = FactoryGirl.create(:content_entity, content: 'http://www.wykop.pl')

        Link.count.must_equal 1
        Note.count.must_equal 0

        cn.contentable.must_equal Link.last
        cn.contentable.to_s.must_equal 'http://www.wykop.pl'
      end
    end

    context 'content contains url and text' do
      it 'must create content entity and note' do
        cn = FactoryGirl.create(:content_entity, content: 'http://www.wykop.pl lorem ipsum')

        Link.count.must_equal 0
        Note.count.must_equal 1

        cn.contentable.must_equal Note.last
        cn.contentable.to_s.must_equal 'http://www.wykop.pl lorem ipsum'
      end
    end

    context 'text only' do
      it 'must create note' do
        cn = FactoryGirl.create(:content_entity, content: '/wwwwykoppl/')

        Link.count.must_equal 0
        Note.count.must_equal 1

        cn.contentable.must_equal Note.last
        cn.contentable.to_s.must_equal '/wwwwykoppl/'
      end
    end
  end

  describe 'save' do
    it 'must fetch title if contentable is link' do
      VCR.use_cassette('webpage') do
        Sidekiq::Testing.inline! do
          cn = FactoryGirl.create(:content_entity, content: 'https://www.prograils.com')

          cn.contentable.is_a?(Link).must_equal true
        end
      end
    end
  end

  describe 'update_with_contentable' do
    it 'it must leave inbox if assigned to group' do
      content_entity = FactoryGirl.create(:content_entity, inbox: true, group: nil)
      group = FactoryGirl.create(:group)
      update_params = { contentEntity: { group_id: group.id } }

      content_entity.inbox?.must_equal true
      content_entity.update_with_contentable(update_params)

      content_entity.reload
      content_entity.inbox?.must_equal false
    end
  end
end
