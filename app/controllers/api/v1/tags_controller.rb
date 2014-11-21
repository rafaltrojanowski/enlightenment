class Api::V1::TagsController < ApplicationController
  respond_to :json

  def index
    respond_with ActsAsTaggableOn::Tag.all
  end

  def show
    respond_with ActsAsTaggableOn::Tag.find(params[:id])
  end
end
