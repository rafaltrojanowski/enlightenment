require "test_helper"

describe Note do
  it 'must leave inbox on update' do
    @note = FactoryGirl.create(:note, title: 'http://www.prograils.com')

    @note.inbox?.must_equal true

    @note.update(body: 'lorem ipsum')

    @note.inbox?.must_equal false
  end
end
