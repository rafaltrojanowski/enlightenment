class GroupsController < ApplicationController
  before_action :set_group, except: [:index, :new, :create]
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
    @group.users << current_user
    respond_to do |format|
      if @group.save
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
    @participants = @group.users.where.not(id: @group.owner.id)
    @collection = User.where.not(id: @group.users.pluck(:id)).pluck(:email)
  end

  def new_participant
    @group.users << User.find_by(email: group_params[:participant])
    redirect_to group_path(@group)
  end

  def remove_participant
    @group.users.destroy(User.find(params[:participant_id]))
    redirect_to group_path(@group)
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :participant)
  end
end
