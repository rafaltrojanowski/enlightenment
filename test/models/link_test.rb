require 'test_helper'

describe Link do

  describe '#save' do
    it 'must fetch title from page if page found' do
      @link = FactoryGirl.build(:link, url: 'https://www.prograils.com')
      @link.save
      @link.title.must_equal 'Prograils - Ruby on Rails web development'
    end

    it 'wont fetch title from page if page not found' do
      @link = FactoryGirl.build(:link, url: 'http://www.prograils.com')
      @link.save
      @link.title.must_equal nil
    end
  end
end
