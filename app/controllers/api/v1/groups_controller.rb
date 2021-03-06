class Api::V1::GroupsController < ApplicationController
  load_and_authorize_resource
  respond_to :json

  def index
    respond_with @groups
  end

  def create
    attrs = {
      name: params[:group][:name],
      icon: params[:group][:icon],
      owner_id: current_user.try(:id)
    }
    group = Group.new(attrs)
    group.users << current_user if group.save
    respond_with :api, :v1, group
  end

  def update
    @group.icon = params[:group][:icon] if params[:group][:icon]
    @group.name = params[:group][:name]
    if ids = params[:group][:userIds]
      @group.user_ids = ids.push(@group.owner_id).uniq
    end
    @group.save

    respond_with :api, :v1, @group
  end

  def other_users
    respond_with @group.other_users(params[:q]), root: false
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

  def group_params
    params.require(:group).permit(group: [:name, :icon])
  end
end
