require 'test_helper'

class TenantTest < ActiveSupport::TestCase
  should "create" do
    result = create(:tenant, schema: 'test')

    assert_kind_of Tenant, result

    assert Tenant.schema_tool.schema_exists?('test')
    result.scope_schema do
      assert Tenant.connection.table_exists?(:groups)
      assert Tenant.connection.table_exists?(:memberships)
    end
  end

  should "scope schema" do
    tenant1 = create(:tenant)
    tenant1.scope_schema do
      group1 = create(:group, name: 'group1')
    end

    tenant2 = create(:tenant)
    tenant2.scope_schema do
      group2 = create(:group, name: 'group2')
    end

    tenant1.scope_schema do
      assert_equal 1, Group.count
      assert_equal 'group1', Group.first.name
    end
  end

  should "perform action for all schema's" do
    tenants = create_list(:tenant, 5)
    count = 0

    Tenant.for_each_schema do
      count += 1
      create(:group, name: 'group')
    end

    assert_equal 6, count
    assert (
      [Tenant::ROOT_TENANT_SCHEMA] + 
      Tenant.pluck(:schema) + 
      Tenant::DEFAULT_SEARCH_PATH
    ).to_set.subset?(Tenant.schema_tool.schemas.to_set)

    tenants.each do |tenant|
      tenant.scope_schema do
        assert_equal 1, Group.count
      end
    end
  end
end
