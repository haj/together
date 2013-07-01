require 'test_helper'

class SchemaToolTest < ActiveSupport::TestCase
  should "create schema" do
    Tenant.schema_tool.create_schema('test_schema')

    assert Tenant.schema_tool.schema_exists?('test_schema')
  end

  should "scope schema" do
    Tenant.schema_tool.create_schema('test_schema')

    assert Tenant.connection.table_exists?('tenants')
    Tenant.schema_tool.with_search_path('test_schema') do
      refute Tenant.connection.table_exists?('tenants')
    end
  end

  should "list existing schemas" do
    Tenant.schema_tool.create_schema('test_schema')

    assert ['test_schema', 'public'].to_set.subset?(Tenant.schema_tool.schemas.to_set)
  end
end
