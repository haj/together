require 'test_helper'

class SchemaTasksTest < ActiveSupport::TestCase
  should "run migrations for schemas" do
    tenant = create(:tenant)
    count = 0
    Tenant.for_each_schema do
      count += 1
      create_test_table
    end

    assert_equal 2, count
    refute Tenant.connection.table_exists?(:test_table)

    tenant.scope_schema do
      assert Tenant.connection.table_exists?(:test_table)
    end

    Tenant.with_root_tenant_schema do
      assert Tenant.connection.table_exists?(:test_table)
    end
  end

  should "dump schema from root tenant" do
    testdir = Rails.root + 'tmp/schema_test'
    testfile = testdir + 'tenant_test_schema.rb'
    FileUtils.mkdir_p(testdir)
    FileUtils.rm_f(testdir)
    tenant = create(:tenant)
    tenant.scope_schema do
      create_test_table
    end

    Tenant.with_root_tenant_schema do
      File.open(testfile, "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end

    assert File.exist?(testdir + 'tenant_test_schema.rb')
    File.open(testdir + 'tenant_test_schema.rb') do |file|
      schema_text = file.read
      refute_includes schema_text, '"test"'
      assert_includes schema_text, '"groups"'
      assert_includes schema_text, '"memberships"'
    end
    
  end

  def create_test_table
    Tenant.connection.create_table(:test_table) do |t|
      t.string :test_string
    end
  end

end