require 'test_helper'

describe GroupsController do

  before do
    @group = FactoryGirl.create(:group)
  end

  it 'must create group' do
    assert_difference('Group.count') do
      post :create, group: { name: 'party', owner_id: 1 }
    end

    must_redirect_to groups_path
  end
end
