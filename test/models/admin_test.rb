require 'test_helper'

describe Administrator do
  before do
    @admin = FactoryGirl.build(:administrator)
    @admin.email = Configurable[:email]
    @admin.password = 'q1w2e3r4'
    @admin.first_name = 'Ala'
    @admin.last_name = 'Kota'
  end

  it 'must be valid' do
    @admin.valid?.must_equal true
  end
end
