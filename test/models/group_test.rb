require 'test_helper'

describe Group do
  describe 'create' do
    it 'must be created' do
      group = FactoryGirl.create(:group)
      group.wont_equal nil
    end
  end

  it 'must nullify content_entity group and set inbox flag' do
    content_entity = FactoryGirl.create(:content_entity, inbox: false)

    content_entity.group.wont_equal nil
    content_entity.inbox?.must_equal false

    content_entity.group.destroy!

    content_entity.reload
    content_entity.group_id.must_equal nil
    content_entity.inbox?.must_equal true
  end
end
