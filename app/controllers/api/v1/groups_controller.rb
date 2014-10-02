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
  end

  def show
    respond_with Group.find(params[:id])
  end
end
