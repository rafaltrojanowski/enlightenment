require 'test_helper'

describe Devise::SessionsController do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:administrator]

    @password = 'testtest123'
    @administrator = FactoryGirl.create(:administrator, password: @password)
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
        post :create, administrator: { email: @administrator.email, password: @password }
        # must_redirect_to root_path
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

  describe "GET 'destroy'" do
    before(:each) do
      sign_in(@administrator)
    end
    it 'should be redirected' do
      get :destroy
      must_redirect_to root_path
    end
  end

end
