class GroupsController < ApplicationController
  before_action :find_group, except: [:new, :create, :index]
  load_and_authorize_resource only: [:show, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    respond_to do |format|
      if @group.save
        @group.users << current_user
        format.html { redirect_to groups_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_path }
      else
        format.html { render :edit }
      end
    end
  end

  def edit
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path }
    end
  end

  def show
  end


  def add_users
    user_ids = params[:group][:user_ids]
    users = User.where(id: user_ids)
    @group.users << users

    redirect_to group_path(@group)
  end

  def delete_user
    user = User.find_by_id(params[:user_id])

    @group.users.delete(user) if user # TODO can't be possible delete group owner!

    redirect_to group_path(@group)
  end

  private

  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :participant)
  end

  def users_for_select(group)
    User.where('id NOT in (?)', group.user_ids).map { |u| [u.email, u.id] }
  end
  helper_method :users_for_select
end
