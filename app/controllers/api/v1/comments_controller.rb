class Api::V1::CommentsController < ApplicationController
  # before_action :load_commentable
  respond_to :json

  def index
  end

  def new
  end

  def show
    respond_with Comment.find(params[:id])
  end

  private

  # def load_commentable
  #   klass = [Link, Note].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
end
