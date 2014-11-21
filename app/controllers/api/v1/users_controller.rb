class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all.includes(:groups)
  end

  def show
    respond_with User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_with_password(user_params)
      render json: user, status: 201
      return
    else
      clean_up_passwords user
      render json: { errors: user.errors.full_messages[0] }, status: 422
      return
    end
  end

  private

  def user_params
    params[:user]
  end
end
