class Api::V1::GroupsController < ApplicationController
  respond_to :json
  before_action :set_group, except: [:index, :create]

  def index
    respond_with current_user.groups
  end

  def create
    attrs = {
      name: params[:group][:name],
      icon: params[:group][:icon],
      owner_id: params[:group][:owner_id]
    }
    group = Group.new(attrs)
    group.user_ids = params[:group][:user_ids]
    group.save
    respond_with :api, :v1, group
  end

  def update
    # raise params.inspect
    # raise params[:group][:users].inspect
    @group.user_ids = params[:group][:users]
    @group.icon = params[:group][:icon]
    @group.name = params[:group][:name]
    @group.save
    respond_with :api, :v1, @group
  end

  def other_users
    @group = Group.find(params[:id])
    respond_with User.all.map{ |user| {:id => user.id, :text => user.name}}, root: false
    # , root: false#.filtering(params[:q]).not_members(@group.user_ids), root: false
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
