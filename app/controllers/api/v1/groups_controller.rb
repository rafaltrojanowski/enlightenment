class Api::V1::GroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :json
  before_action :set_group, except: [:index, :create]

  def index
    respond_with current_user.groups
  end

  def create
    attrs = {
      name: params[:group][:name],
      icon: params[:group][:icon],
      owner_id: current_user.id
    }
    group = Group.new(attrs)
    group.users << current_user
    group.save
    respond_with :api, :v1, group
  end

  def update
    @group.icon = params[:group][:icon]
    @group.name = params[:group][:name]
    if ids = params[:group][:userIds]
      @group.user_ids = ids.push(@group.owner_id).uniq
    end
    @group.save
    respond_with :api, :v1, @group
  end

  def other_users
    @group = Group.find(params[:id])
    respond_with User.filtering(params[:q]).not_members(@group.user_ids), root: false
  end

  def members
    respond_with @group.users.map { |u| { id: u.id, email: u.email }}, root: false
  end

  def show
    respond_with @group
  end

  def destroy
    respond_with @group.destroy
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
