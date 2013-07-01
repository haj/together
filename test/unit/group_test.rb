require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  should "create" do
    Tenant.with_root_tenant_schema do
      result = create(:group)

      assert_kind_of Group, result
    end
  end
end