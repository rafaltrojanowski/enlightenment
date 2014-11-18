require 'test_helper'

describe 'Api::V1::Comments' do

  before do
    @commenter = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @content_entity = FactoryGirl.create(:content_entity)
    @comment = FactoryGirl.create(:comment, commentable: @content_entity,
                                            user: @commenter)
  end

  describe 'destroy' do
    it 'comment owner must destroy' do
      auth_data = { token: @commenter.authentication_token,
                    user_email: @commenter.email }

      api_call :delete, "comments/#{@comment.id}", auth_data

      response.status.must_equal 204
    end

    it 'user wont destroy' do
      auth_data = { token: @user.authentication_token, user_email: @user.email }

      lambda do
        api_call :delete, "comments/#{@comment.id}", auth_data
      end.must_raise CanCan::AccessDenied
    end

    it 'not authorized wont destroy' do
      lambda do
        api_call :delete, "comments/#{@comment.id}"
      end.must_raise CanCan::AccessDenied
    end
  end
end
