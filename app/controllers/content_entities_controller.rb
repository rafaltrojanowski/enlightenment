class ContentEntitiesController < ApplicationController
  inherit_resources

  private

  def permitted_params
    params.permit(content_entity: [:content])
  end
end
