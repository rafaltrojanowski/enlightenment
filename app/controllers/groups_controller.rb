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
    @preload_users = @group.users.where.not(id: @group.owner_id).to_json
  end

  def update_users
    user_ids = group_params[:user_tokens].split(',').map(&:to_i)
    @users = User.find(user_ids)

    @group.users.each do |member|
      delete_user(member) if @users.exclude? member
    end

    @users.each do |new_member|
      add_user(new_member) if @group.users.exclude? new_member
    end
    redirect_to group_path(@group)
  end

  def other_users
    respond_to do |format|
      format.json { render json: User.filtering(params[:q]).not_members(@group.user_ids), root: false }
    end
  end

  private

  def add_user(user)
    @group.users << user
  end

  def delete_user(user)
    @group.users.delete(user) if user && user != @group.owner
  end

  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :user_tokens)
  end
end
