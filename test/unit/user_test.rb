require 'test_helper'

describe User do
  it "should creat" do
    result = create(:group)

    assert_kind_of Group, result
  end
end