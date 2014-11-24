require 'test_helper'

describe 'Api::V1::Groups' do
  before do
    @owner = FactoryGirl.create(:user)
    @member = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)

    @group = FactoryGirl.create(:group, owner_id: @owner.id)
    @group.users << @member

    @group.users.count.must_equal 1
    @group.users.must_include @member
  end

  describe 'index' do
    it 'must member get resource' do
      member_data = { token: @member.authentication_token, user_email: @member.email }

      api_call :get, "groups", member_data

      response.status.must_equal 200
      json['groups'].wont_equal []
    end

    it 'wont owner get resource' do
      # owner is always member, so this test is for check abilities only

      owner_data = { token: @owner.authentication_token, user_email: @owner.email }
      api_call :get, "groups", owner_data

      response.status.must_equal 200
      json['groups'].must_equal []
    end

    it 'wont user get resource' do
      user_data = { token: @user.authentication_token, user_email: @user.email }

      api_call :get, "groups", user_data

      response.status.must_equal 200
      json['groups'].must_equal []
    end
  end

  describe 'show' do
    it 'must member get resource' do
      member_data = { token: @member.authentication_token, user_email: @member.email }

      api_call :get, "groups/#{@group.id}", member_data

      response.status.must_equal 200
      json['group'].wont_equal []
    end

    it 'wont user get resource' do
      user_data = { token: @user.authentication_token, user_email: @user.email }

      @group.user_ids = nil
      @group.users.must_equal []

      lambda do
        api_call :get, "groups/#{@group.id}", user_data
      end.must_raise CanCan::AccessDenied
    end

    it 'wont owner get resource' do
      owner_data = { token: @owner.authentication_token, user_email: @owner.email }

      lambda do
        api_call :get, "groups/#{@group.id}", owner_data
      end.must_raise CanCan::AccessDenied
    end
  end

  describe 'create' do
    it 'must user create group' do
      user_data = { token: @user.authentication_token, user_email: @user.email }
      group_params = { group: { name: 'ember', icon: 'fa-icon' } }

      assert_difference(['Group.count', 'Participant.count'], 1) do
        api_call :post, "groups", user_data, group_params
      end
    end

    it 'wont not authorized user create group' do
      user_data = { token: 'wrong-token', user_email: @user.email }
      group_params = { group: { name: 'ember' } }

      assert_difference(['Group.count', 'Participant.count'], 0) do
        api_call :post, "groups", user_data, group_params
      end
    end
  end

  describe 'update' do
    it 'must owner update group' do
      owner_data = { token: @owner.authentication_token, user_email: @owner.email }
      update_params = { group: { name: 'ember-js' } }

      api_call :put, "groups/#{@group.id}", owner_data, update_params

      @group.reload
      @group.name.must_equal 'ember-js'
      @group.icon.wont_equal nil
    end

    it 'must owner add new members' do
      owner_data = { token: @owner.authentication_token, user_email: @owner.email }
      update_params = { group: { userIds: [@user.id] } }

      api_call :put, "groups/#{@group.id}", owner_data, update_params

      @group.reload
      @group.user_ids.sort.must_equal [@owner, @user].map(&:id).sort
    end

    it 'wont member update group' do
      member_data = { token: @member.authentication_token, user_email: @member.email }
      update_params = { group: { name: 'ember-js', icon: 'fa-icon-user' } }

      lambda do
        api_call :put, "groups/#{@group.id}", member_data, update_params
      end.must_raise CanCan::AccessDenied
    end
  end

  describe 'destroy' do
    it 'must owner destroy group' do
      owner_data = { token: @owner.authentication_token, user_email: @owner.email }

      assert_difference(['Group.count', 'Participant.count'], -1) do
        api_call :delete, "groups/#{@group.id}", owner_data
      end
    end

    it 'wont member destroy group' do
      member_data = { token: @member.authentication_token, user_email: @member.email }

      assert_difference(['Group.count', 'Participant.count'], 0) do
        lambda do
          api_call :delete, "groups/#{@group.id}", member_data
        end.must_raise CanCan::AccessDenied
      end
    end
  end

  describe 'members' do
    it 'must owner get members' do
      owner_data = { token: @owner.authentication_token, user_email: @owner.email }

      api_call :get, "groups/#{@group.id}/members", owner_data

      arr = @group.users.map { |u| [u.id, u.email] }.flatten

      json.must_equal [{"id"=>arr[0], "email"=>"#{arr[1]}"}]
    end

    it 'wont member get members' do
      member_data = { token: @member.authentication_token, user_email: @member.email }

      lambda do
        api_call :get, "groups/#{@group.id}/members", member_data
      end.must_raise CanCan::AccessDenied
    end
  end

  describe 'other users' do
    it 'must owner get other users' do
      owner_data = { token: @owner.authentication_token, user_email: @owner.email }

      api_call :get, "groups/#{@group.id}/other_users", owner_data

      json.map(&:with_indifferent_access).must_equal @group.other_users(nil).map(&:with_indifferent_access)
    end

    it 'wont member get members' do
      member_data = { token: @member.authentication_token, user_email: @member.email }

      lambda do
        api_call :get, "groups/#{@group.id}/other_users", member_data
      end.must_raise CanCan::AccessDenied
    end
  end
end
