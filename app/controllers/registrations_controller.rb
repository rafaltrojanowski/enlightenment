class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_scope!
  respond_to :json

  def new
    super
  end

  def create
    # add custom create logic here
  end

  def update
    resource = resource_class.find(params[:id])
    if resource.update_without_password(resource_params)
      render json: resource, status: 201
    else
      clean_up_passwords resource
      render json: { errors: resource.errors.full_messages[0] }, status: 422
    end
  end
end
