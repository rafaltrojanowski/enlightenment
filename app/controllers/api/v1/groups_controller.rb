class Api::V1::GroupsController < ApplicationController
  respond_to :json
  before_action :set_group, except: [:index, :create]

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
    @group.user_ids = params[:group][:users]
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
