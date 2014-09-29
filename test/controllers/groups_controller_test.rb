require 'test_helper'
describe GroupsController do
  before do
    @owner= FactoryGirl.create(:user)
    @participant = FactoryGirl.create(:user)

    @group = FactoryGirl.create(:group, owner_id: @owner.id)
    @group.users << @owner
    @group.users << @participant
  end

  describe 'not signed in' do
    it 'wont show group' do
      get :show, id: @group
      assert_response :redirect # 302
      flash[:alert].must_equal 'You are not authorized to access this page.'
    end

    it 'wont index group' do
      get :show, id: @group
      assert_response :redirect # 302
      flash[:alert].must_equal 'You are not authorized to access this page.'
    end
  end

  describe 'signed in' do
    context 'owner' do
      before do
        sign_in(@owner)
      end

      it 'must create group' do
        assert_difference('Group.count') do
          post :create, group: { name: 'party' }
        end

        must_redirect_to groups_path
      end

      it 'must destroy group' do
        assert_difference('Group.count', -1) do
          delete :destroy, id: @group
        end

        must_redirect_to groups_path
      end

      it 'must edit' do
        get :edit, id: @group

        assert_response :success
      end

      it 'must update' do
        patch :update, id: @group, group: { name: 'bleble' }

        must_redirect_to groups_path
      end

      it 'must get new' do
        get :new
        assert_response :success
      end

      it 'must show group' do
        get :show, id: @group
        assert_response :success
      end

      it 'must post update_users with tokens' do
        post :update_users, id: @group, group: { user_tokens: @participant.id } # or "1,2,3"

        must_redirect_to group_path(@group)
      end

      it 'must post update_users with empty tokens' do
        post :update_users, id: @group, group: { user_tokens: ''}

        must_redirect_to group_path(@group)
      end

      it 'must get other_users' do
        get :other_users, id: @group, format: :json
        assert_response :success
      end
    end

    context 'participant' do
      before do
        sign_in(@participant)
      end

      it 'test that participant is not owner' do
        @group.owner.wont_equal @participant
      end

      it 'must create group' do
        assert_difference('Group.count') do
          post :create, group: { name: 'party' }
        end

        must_redirect_to groups_path
      end

      it 'wont destroy group' do
        assert_difference('Group.count', 0) do
          delete :destroy, id: @group
        end

        assert_redirected_to root_url
        flash[:alert].wont_equal nil
      end

      it 'wont edit' do
        get :edit, id: @group

        assert_redirected_to root_url
        flash[:alert].wont_equal nil
      end

      it 'wont update' do
        patch :update, id: @group, group: { name: 'bleble' }

        assert_redirected_to root_url
        flash[:alert].wont_equal nil
      end

      it 'must get new' do
        get :new
        assert_response :success
      end

      it 'must show group' do
        get :show, id: @group
        assert_response :success
      end

      it 'wont post update_users' do
        post :update_users, id: @group, group: { user_tokens: ''}

        must_redirect_to root_url
      end

      it 'wont get other_users' do
        get :other_users, id: @group, format: :json

        must_redirect_to root_url
        flash[:alert].wont_equal nil
      end
    end

    context 'not related user' do
      before do
        @user = FactoryGirl.create(:user)

        sign_in(@user)
      end

      it 'test that user is not participant or owner' do
        @group.user_ids.wont_include @user.id
        @group.owner_id.wont_equal @user.id
      end

      it 'should get new' do
        get :new

        assert_response :success
      end

      it 'must create group' do
        assert_difference('Group.count') do
          post :create, group: { name: 'party' }
        end

        must_redirect_to groups_path
      end

      it 'wont destroy others group ' do
        assert_difference('Group.count', 0) do
          delete :destroy, id: @group
        end

        must_redirect_to root_url
        flash[:alert].wont_equal nil
      end

      it 'wont edit' do
        get :edit, id: @group

        must_redirect_to root_url
        flash[:alert].wont_equal nil
      end

      it 'wont update' do
        patch :update, id: @group, group: { name: 'bleble' }

        must_redirect_to root_url
        flash[:alert].wont_equal nil
      end

      it 'wont show group' do
        get :show, id: @group

        must_redirect_to root_url
        flash[:alert].wont_equal nil
      end

      it 'wont post update_users' do
        post :update_users, id: @group, group: { user_tokens: ''}

        must_redirect_to root_url
        flash[:alert].wont_equal nil
      end

      it 'wont get other_users' do
        get :other_users, id: @group, format: :json

        must_redirect_to root_url
        flash[:alert].wont_equal nil
      end
    end
  end
end
