require 'test_helper'

describe Devise::UnlocksController do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:administrator]

    @administrator = FactoryGirl.create(:administrator)
    @unlock_token = @administrator.lock_access!
  end

  describe "GET 'new'" do
    it 'should be successful' do
      get :new
      must_respond_with :success
      # must_render_template 'new'
    end
  end

  describe "GET 'create'" do
    context 'with valid params' do
      it 'should be redirected' do
        post :create, administrator: { Administrator.unlock_keys.first => @administrator.send(Administrator.unlock_keys.first) }
        must_redirect_to new_administrator_session_path
      end
    end
    context 'with invalid params' do
      it 'should be successful' do
        post :create, administrator: {}
        must_respond_with :success
        # must_render_template 'new'
      end
    end
  end

  describe "GET 'show'" do
    before(:each) do
    end
    context 'with valid token' do
      it 'should be redirected' do
        get :show, unlock_token: @unlock_token
        must_redirect_to new_administrator_session_path
      end
    end
    context 'with invalid token' do
      it 'should be successful' do
        get :show, unlock_token: 'invalid-token'
        must_respond_with :success
        # must_render_template 'new'
      end
    end
  end
end
