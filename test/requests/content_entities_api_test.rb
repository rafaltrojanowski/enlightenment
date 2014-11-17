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

  it 'must create content entity if user signed in' do
    before = ContentEntity.count

    data = { contentEntity: { body: 'w of wall', user_id: @user.id } }

    api_call :post, 'contentEntities', @auth_data, data

    after = ContentEntity.count
    expected_user = Note.where(body: 'w of wall').first.content_entity.user

    (before + 1).must_equal after

    expected_user.must_equal @user
  end

  it 'wont create content entity if user signed in' do
    data = { contentEntity: { body: 'test' } }

    before = ContentEntity.count
    api_call :post, 'contentEntities', {}, data
    after = ContentEntity.count

    (before - after).must_equal 0
  end
end
