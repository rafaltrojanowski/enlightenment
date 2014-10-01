class Api::V1::LinksController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.links
  end

  def show
    respond_with Link.find(params[:id])
  end
end
