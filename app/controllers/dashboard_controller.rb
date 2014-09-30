class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @content_entities = ContentEntity.all
  end
end
