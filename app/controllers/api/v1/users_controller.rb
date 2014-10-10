class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all
  end

  def create
    attrs = {
      email: params[:user][:email],
      password: 'zakonnica'
    }
    respond_with :api, :v1, User.create(attrs)
  end

  def show
    respond_with User.find(params[:id])
  end
end
