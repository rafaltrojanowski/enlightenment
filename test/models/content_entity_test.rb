require "test_helper"
require 'sidekiq/testing'

describe ContentEntity do
  describe 'create' do
    context 'content contains url only' do
      it 'must create content entity and link' do
        cn = ContentEntity.create!(content: 'http://www.wykop.pl')

        Link.count.must_equal 1
        Note.count.must_equal 0

        cn.contentable.must_equal Link.last
        cn.contentable.to_s.must_equal 'http://www.wykop.pl'
      end
    end

    context 'content contains url and text' do
      it 'must create content entity and note' do
        cn = ContentEntity.create!(content: 'http://www.wykop.pl lorem ipsum')

        Link.count.must_equal 0
        Note.count.must_equal 1

        cn.contentable.must_equal Note.last
        cn.contentable.to_s.must_equal 'http://www.wykop.pl lorem ipsum'
      end
    end

    context 'text only' do
      it 'must create note' do
        cn = ContentEntity.create!(content: '/wwwwykoppl/')

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
          sleep 1
          cn.contentable.reload.title.must_equal 'Prograils - Ruby on Rails web development'
        end
      end
    end
  end
end
