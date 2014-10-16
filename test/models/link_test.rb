require 'test_helper'

describe Link do

  describe 'after_commit callback' do
    # the problem is that after_commit callback is called, well, after the
    # save transaction gets commited, which actually never happens in minitest
    # if you have transactional fixtures on

    # @HACK object.send(:callback_method)
    # or use https://github.com/grosser/test_after_commit
    it 'must fetch title from page if page found' do
      VCR.use_cassette('webpage') do
        Sidekiq::Testing.inline! do
          @link = FactoryGirl.create(:link, url: 'https://www.prograils.com')
          @link.send(:fetch_title)
          @link.reload.title.must_equal 'Prograils - Ruby on Rails web development'
        end
      end
    end

    it 'wont fetch title from page if page not found' do
      VCR.use_cassette('webpage') do
        Sidekiq::Testing.inline! do
          @link = FactoryGirl.create(:link, url: 'http://www.prograils.com')
          @link.send(:fetch_title)
          @link.reload.title.must_equal nil
        end
      end
    end
  end
end
