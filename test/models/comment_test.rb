require "test_helper"

describe Comment do
  before do
    @comment = FactoryGirl.create(:comment)
  end

  it "must be valid" do
    @comment.must_be :valid?
  end
end
