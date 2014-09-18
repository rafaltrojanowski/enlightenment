require 'test_helper'

describe Admin::AdministratorsController do

  before do
    @administrator = FactoryGirl.create(:administrator)
    login_as_administrator(@administrator)
    @admin_attrs = FactoryGirl.attributes_for(:administrator, email: 'test@prograils.com')
  end

  it 'must get index' do
    get :index
    must_respond_with :success
    assert_not_nil assigns(:administrators)
  end

  it 'must get new' do
    get :new
    must_respond_with :success
  end

  it 'must create admin_administrator' do
    assert_difference('Administrator.count') do
      post :create, administrator: @admin_attrs
    end

    must_redirect_to admin_administrator_path(assigns(:administrator))
  end

  it 'must show admin' do
    get :show, id: @administrator
    must_respond_with :success
  end

  it 'must get edit' do
    get :edit, id: @administrator
    must_respond_with :success
  end

  it 'must update admin' do
    put :update, id: @administrator.id, administrator: { first_name: 'Ala' }
    must_redirect_to admin_administrator_path(assigns(:administrator))
    assigns(:administrator).first_name.must_equal 'Ala'
  end

  it 'must destroy admin' do
    assert_difference('Administrator.count', -1) do
      delete :destroy, id: @administrator
    end

    must_redirect_to admin_administrators_path
  end

end
