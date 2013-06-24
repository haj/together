require 'test_helper'

describe Group do
  it "should create" do
    result = create(:group)

    assert_kind_of Group, result
  end
end