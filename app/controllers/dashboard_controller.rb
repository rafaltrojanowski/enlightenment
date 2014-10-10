class DashboardController < ApplicationController
  def index
    @content_entities = ContentEntity.all
  end
end
