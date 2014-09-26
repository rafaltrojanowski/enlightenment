class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :find_group, except: [:new, :create, :index]

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
    @preload_users = @group.users.where.not(id: @group.owner_id).to_json
  end

  def update_users
    new_user_ids = group_params[:user_tokens].split(',').map(&:to_i)
    @group.user_ids = new_user_ids << @group.owner_id

    redirect_to group_path(@group)
  end

  def other_users
    respond_to do |format|
      format.json { render json: User.filtering(params[:q]).not_members(@group.user_ids), root: false }
    end
  end

  private

  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :user_tokens)
  end
end
