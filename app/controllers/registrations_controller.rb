class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_scope!
  respond_to :json

  def new
    super
  end

  def create
    super
  end

  def update
    resource = resource_class.find(params[:id])
    resource_updated = update_resource(resource, account_update_params)
    if resource_updated
      render json: resource, status: 201
    else
      clean_up_passwords resource
      render json: { error: resource.errors.full_messages[0] }, status: 422
    end
  end
end
