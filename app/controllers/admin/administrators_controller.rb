class Admin::AdministratorsController < Admin::BaseController
  inherit_resources
  defaults route_prefix: 'admin'

  def index
    @q = Administrator.search(params[:q])
    @q.sorts = 'last_name ASC' if @q.sorts.blank?
    @administrators = @q.result(distinct: true).page(params[:page])
  end

  def show
    @administrator = Administrator.find(params[:id].to_i)
    @password = session.delete(:admin_password)
  end

  def create
    password = Devise.friendly_token.first(8)
    @administrator = Administrator.new(resource_params.merge(password: password))
    if @administrator.save
      session[:admin_password] = password
      redirect_to [:admin, @administrator]
    else
      render action: :new
    end
  end

  def update
    @administrator = Administrator.find(params[:id])
    if @administrator.update_attributes(resource_params)
      redirect_to [:admin, @administrator]
    else
      render action: :edit
    end
  end

  private

  def resource_params
    if p = params[resource_instance_name].presence
      p.permit(:email, :first_name, :last_name)
    else
      {}
    end
  end
end
