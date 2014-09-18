require 'test_helper'

describe Devise::PasswordsController do

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:administrator]
    @administrator = FactoryGirl.create(:administrator)
  end

  describe "GET 'new'" do
    it 'should be successful' do
      get :new
      must_respond_with :success
      must_render_template 'new'
    end
  end

  describe "GET 'create'" do
    context 'with valid params' do
      it 'should be redirected' do
        post :create, administrator: { Administrator.reset_password_keys.first => @administrator.send(Administrator.reset_password_keys.first) }
        must_redirect_to new_administrator_session_path
      end
    end
    context 'with invalid params' do
      it 'should be successful' do
        post :create, administrator: {}
        must_respond_with :success
        must_render_template 'new'
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @administrator.send_reset_password_instructions
    end
    it 'should be successful' do
      get :edit, reset_password_token: @administrator.reset_password_token
      must_respond_with :success
      must_render_template 'edit'
    end
  end

  describe "GET 'update'" do
    before(:each) do
      @token = @administrator.send_reset_password_instructions
    end
    context 'with valid token' do
      it 'should be redirected' do
        put :update, administrator: { reset_password_token: @token, password: 'testtest123', password_confirmation: 'testtest123' }
        must_redirect_to root_path
      end
    end
    context 'with invalid token' do
      it 'should be successful' do
        put :update, administrator: { reset_password_token: 'wrong-token', password: 'testtest123', password_confirmation: 'testtest123' }
        must_respond_with :success
        must_render_template 'edit'
      end
    end
  end

end
