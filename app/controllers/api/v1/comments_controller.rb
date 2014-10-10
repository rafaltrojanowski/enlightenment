class Api::V1::CommentsController < ApplicationController
  # before_action :load_commentable
  respond_to :json

  def index
  end

  def create
    attrs = {
      content: params[:comment][:content],
      user_id: current_user.id
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
    params.require(:comment).permit(:content, :user_id)
  end
end
