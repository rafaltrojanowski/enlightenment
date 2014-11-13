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
    new_params = account_update_params

    if account_update_params[:avatar].include? 'data'
      parse_avatar_data(account_update_params[:avatar])
      new_params[:avatar] = File.open(@tempfile)
      clean_tempfile
    end

    resource_updated = update_resource(resource, new_params)
    if resource_updated
      render json: resource, status: 201
    else
      clean_up_passwords resource
      render json: { error: resource.errors.full_messages[0] }, status: 422
    end
  end

  private

  def parse_avatar_data(image_data)
    parts = image_data.split(',')
    @tempfile = Tempfile.new('avatar')
    @tempfile.binmode
    @tempfile.write Base64.decode64(parts[1])
    @tempfile.rewind
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end
end
