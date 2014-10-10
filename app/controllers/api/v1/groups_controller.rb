class Api::V1::GroupsController < ApplicationController
  respond_to :json

  def index
    respond_with Group.all
  end

  def create
    attrs = {
      name: params[:group][:name],
      owner_id: current_user.id
    }

    respond_with :api, :v1, Group.create(attrs)
    Group.last.users << current_user
  end

  def update
    group = Group.find(params[:id])
    group.user_ids = params[:group][:users]
    respond_with :api, :v1, group
  end

  def other_users
    group = Group.find(params[:id])
    respond_with User.filtering(params[:q]).not_members(group.user_ids), root: false
  end

  def show
    respond_with Group.find(params[:id])
  end
end
