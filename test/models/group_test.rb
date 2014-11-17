require 'test_helper'

describe Group do
  describe 'create' do
    it 'must be created' do
      group = Group.create!(name: 'koty', owner_id: 1)

      Group.count.must_equal 1

      group.must_equal Group.last
    end

    it 'wont be valid without name' do
      group = Group.new(owner_id: 1)

      group.wont_be :valid?
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
