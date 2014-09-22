require 'test_helper'
describe GroupsController do

  before do
    user = FactoryGirl.create(:user)
    @group = FactoryGirl.create(:group, owner_id: user.id)
    @group.users << user
    sign_in(user)
  end

  it 'must create group' do
    assert_difference('Group.count') do
      post :create, group: { name: 'party' }
    end

    must_redirect_to groups_path
  end

  it 'should destroy group' do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_redirected_to groups_path
  end

  it 'should be update' do
    patch :update, id: @group, group: { name: 'bleble' }

    assert_redirected_to groups_path
  end

  it 'should get new' do
    get :new
    assert_response :success
  end

  it 'should show group' do
    get :show, id: @group
    assert_response :success
  end
end
