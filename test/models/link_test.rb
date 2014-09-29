require 'test_helper'

describe Link do

  describe '#save' do
    it 'must fetch title from page if page found' do
      VCR.use_cassette('webpage') do
        Sidekiq::Testing.inline! do
          @link = FactoryGirl.create(:link, url: 'https://www.prograils.com')
          @link.reload.title.must_equal 'Prograils - Ruby on Rails web development'
        end
      end
    end

    it 'wont fetch title from page if page not found' do
      VCR.use_cassette('webpage') do
        Sidekiq::Testing.inline! do
          @link = FactoryGirl.create(:link, url: 'http://www.prograils.com')
          @link.reload.title.must_equal nil
        end
      end
    end
  end
end
