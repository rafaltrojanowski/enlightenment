require "test_helper"

describe Link do
  let(:link) { Link.new }

  it "must be valid" do
    link.must_be :valid?
  end
end
