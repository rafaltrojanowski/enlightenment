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
end
