class GroupsController < ApplicationController
  before_action :set_group, only: [:show,
                                   :edit,
                                   :update,
                                   :destroy,
                                   :new_participant,
                                   :remove_participant]

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
        Participant.create(group_id: @group.id, user_id: current_user.id)
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
    participant_id =  User.find_by(email: group_params[:participant]).id
    Participant.create(group_id: @group.id, user_id: participant_id)
    redirect_to group_path(@group)
  end

  def remove_participant
    @participant = Participant.find_by(user_id: params[:participant_id].to_i)
    @participant.destroy
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
