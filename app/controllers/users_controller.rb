class UsersController < ApplicationController
  inherit_resources
  actions :edit, :update

  before_action :authenticate_user!
  load_and_authorize_resource

  private

  def permitted_params
    params.permit(user: [:username, :avatar, :avatar_cache, :remove_avatar])
  end
end
