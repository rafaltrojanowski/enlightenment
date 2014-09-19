class Api::V1::NotesController < ApplicationController
  respond_to :json

  def index
    respond_with Note.all
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end
end
