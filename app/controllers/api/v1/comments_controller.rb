class Api::V1::CommentsController < ApplicationController
  # before_action :load_commentable
  respond_to :json

  def index
    respond_with Comment.all
  end

  def create
    # raise params.inspect
    attrs = {
      content: params[:comment][:content],
      user_id: current_user.id,
      commentable_id: params[:comment][:commentable_id],
      commentable_type: params[:comment][:commentable_type]
    }

    respond_with :api, :v1, Comment.create(attrs)
  end

  def show
    respond_with Comment.find(params[:id])
  end

  private

  # def load_commentable
  #   klass = [Link, Note].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_id, :commentable_type)
  end
end
