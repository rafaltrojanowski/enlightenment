require 'test_helper'

describe 'Api::V1::ContentEntities' do
  def prepare_content_entities
    @my_note_rails_entity = FactoryGirl.create(:content_entity, group: @rails_group, user: @user)
    @my_link_rails_entity = FactoryGirl.create(:content_entity,
                                               content: 'https://www.prograils.com',
                                               group: @rails_group,
                                               user: @user)
    @my_ember_entity = FactoryGirl.create(:content_entity, group: @ember_group, user: @user)

    # i'm not member of angular
    @my_angular_entity = FactoryGirl.create(:content_entity, group: @angular_group, user: @user)

    @other_user_rails_entity = FactoryGirl.create(:content_entity, group: @rails_group, user: @other_user)
    @other_user_angular_entity = FactoryGirl.create(:content_entity, group: @angular_group, user: @other_user)

    @user_entity_without_group = FactoryGirl.create(:content_entity, group: nil, user: @user)
    @other_user_entity_without_group = FactoryGirl.create(:content_entity, group: nil, user: @other_user)

    @my_inbox = FactoryGirl.create(:content_entity, user: @user, inbox: true)
    @other_user_inbox = FactoryGirl.create(:content_entity, user: @other_user, inbox: true)
  end

  before do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)

    @auth_data = { token: @user.authentication_token, user_email: @user.email }

    @rails_group = FactoryGirl.create(:group, name: 'Rails')
    @ember_group = FactoryGirl.create(:group, name: 'Ember')

    @angular_group = FactoryGirl.create(:group, name: 'Angular')

    @user.groups << @rails_group
    @user.groups << @ember_group

    prepare_content_entities
  end

  it 'must retrieve entities that belongs to user groups' do
    api_call :get, 'contentEntities', @auth_data

    response.status.must_equal 200

    body = JSON.parse(response.body)
    ids = body['content_entities'].map { |m| m['id'] }

    ids.sort.must_equal [@my_link_rails_entity.id,
                         @my_note_rails_entity.id,
                         @my_ember_entity.id,
                         @other_user_rails_entity.id].sort
  end

  it 'must retrieve user notes' do
    api_call :get, 'contentEntities', @auth_data, type: 'note'

    body = JSON.parse(response.body)
    ids = body['content_entities'].map { |m| m['id'] }

    ids.sort.must_equal [@my_note_rails_entity.id, @my_ember_entity.id].sort
  end

  it 'must retrieve user links' do

    api_call :get, 'contentEntities', @auth_data, type: 'link'

    body = JSON.parse(response.body)
    ids = body['content_entities'].map { |m| m['id'] }

    ids.sort.must_equal [@my_link_rails_entity.id].sort
  end

  it 'must retrieve user inbox' do
    api_call :get, 'contentEntities', @auth_data, inbox: true

    body = JSON.parse(response.body)
    ids = body['content_entities'].map { |m| m['id'] }

    ids.sort.must_equal [@my_inbox.id].sort
  end

  context 'create' do
    it 'must create content entity if user signed in' do
      params = { contentEntity: { body: 'w of wall' } }

      assert_difference('ContentEntity.count', 1) do
        api_call :post, 'contentEntities', @auth_data, params
      end

      expected_user = Note.where(body: 'w of wall').first.content_entity.user
      expected_user.must_equal @user
    end

    it 'wont create content entity if user signed in' do
      data = { contentEntity: { body: 'test' } }

      assert_difference('ContentEntity.count', 0) do
        api_call :post, 'contentEntities', {}, data
      end
    end
  end

  context 'show' do
    it 'must show my content entity' do
      api_call :get, "contentEntities/#{@my_ember_entity.id}", @auth_data

      response.status.must_equal 200
    end

    it 'wont show others content entity' do
      lambda do
        api_call :get, "contentEntities/#{@other_user_angular_entity.id}", @auth_data
      end.must_raise CanCan::AccessDenied
    end

    it 'wont show if not authorized' do
      lambda do
        api_call :get, "contentEntities/#{@my_ember_entity.id}", {}
      end.must_raise CanCan::AccessDenied
    end
  end

  context 'update' do
    before do
      @update_params = { contentEntity: { body: 'Coffee' } }
    end

    it 'must update my note body' do
      @my_ember_entity.body.must_equal 'MyText'

      api_call :put, "contentEntities/#{@my_ember_entity.id}", @auth_data, @update_params

      response.status.must_equal 200
      @my_ember_entity.reload.body.must_equal 'Coffee'
    end

    it 'must update my link title' do
      params = { contentEntity: { title: 'MyTitle' } }

      api_call :put, "contentEntities/#{@my_link_rails_entity.id}", @auth_data, params

      response.status.must_equal 200
    end

    it 'wont update others content entity' do
      lambda do
        api_call :put, "contentEntities/#{@other_user_angular_entity.id}", @auth_data, @update_params
      end.must_raise CanCan::AccessDenied
    end

    it 'wont update if not authorized' do
      lambda do
        api_call :put, "contentEntities/#{@my_ember_entity.id}", {}, @update_params
      end.must_raise CanCan::AccessDenied
    end
  end

  context 'destroy' do
    it 'must destroy my content entity' do
      assert_difference('ContentEntity.count', -1) do
        api_call :delete, "contentEntities/#{@my_ember_entity.id}", @auth_data
      end
    end

    it 'wont destroy others content entity' do
      assert_difference('ContentEntity.count', 0) do
        lambda do
          api_call :delete, "contentEntities/#{@other_user_angular_entity.id}", @auth_data
        end.must_raise CanCan::AccessDenied
      end
    end

    it 'wont destroy if not authorized' do
      assert_difference('ContentEntity.count', 0) do
        lambda do
          api_call :delete, "contentEntities/#{@my_ember_entity.id}", {}
        end.must_raise CanCan::AccessDenied
      end
    end
  end
end
