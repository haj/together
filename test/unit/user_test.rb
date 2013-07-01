require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "create" do
    result = create(:user)

    assert_kind_of User, result
  end
end