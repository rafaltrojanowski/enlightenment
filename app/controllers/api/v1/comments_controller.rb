class Api::V1::CommentsController < ApplicationController
  load_and_authorize_resource
  respond_to :json

  def index
    respond_with Comment.all.ordered
  end

  def create
    attrs = {
      content: params[:comment][:content],
      user_id: params[:comment][:user_id],
      commentable_id: params[:comment][:commentable_id],
      commentable_type: params[:comment][:commentable_type]
    }

    respond_with :api, :v1, Comment.create(attrs)
  end

  def show
    respond_with Comment.find(params[:id])
  end

  def destroy
    respond_with Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_id, :commentable_type)
  end
end
