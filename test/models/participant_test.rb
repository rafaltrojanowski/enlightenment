require "test_helper"

describe Participant do
  let(:participant) { Participant.new }

  it "must be valid" do
    participant.must_be :valid?
  end
end
