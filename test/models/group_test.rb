require "test_helper"

describe Group do
  let(:group) { Group.new }

  it "must be valid" do
    group.must_be :valid?
  end
end
