module AuthHelpers
  def login_as_administrator(user = nil, &block)
    current_administrator = user || FactoryGirl.create(:administrator)
    if request.present?
      sign_in(current_administrator)
    else
      login_as(current_administrator, scope: :administrator)
    end
    block.call if block.present?
    self
  end

  def login_as_customer(user = nil, &block)
    current_customer = user || FactoryGirl.create(:customer)
    if request.present?
      sign_in(current_customer)
    else
      login_as(current_customer, scope: :customer)
    end
    block.call if block.present?
    self
  end
end
