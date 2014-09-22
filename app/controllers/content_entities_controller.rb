class ContentEntitiesController < ApplicationController
  inherit_resources
  actions :create

  def create
    create! { dashboard_url }
  end

  private

  def permitted_params
    params.permit(content_entity: [:content])
  end
end
