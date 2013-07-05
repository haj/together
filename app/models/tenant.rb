class Tenant < ActiveRecord::Base
  validates :domain, :schema, presence: true

  # ===== Creating =====

  after_create :create_schema

  def create_schema
    schema_tool.create_schema(schema) unless schema_tool.schema_exists?(schema)
    scope_schema do
      load Tenant.tenant_schema_path
    end
  end

  # ===== Scoping =====

  ROOT_TENANT_SCHEMA = '_root_tenant'
  DEFAULT_SEARCH_PATH = ['public']

  def self.with_root_tenant_schema &block
    # If no root tenant schema exists, create it
    unless schema_tool.schema_exists?(ROOT_TENANT_SCHEMA)
      schema_tool.create_schema(ROOT_TENANT_SCHEMA) 
    end
    
    schema_tool.with_search_path(ROOT_TENANT_SCHEMA, &block)
  end

  def scope_schema &block
    schema_tool.with_search_path schema, *DEFAULT_SEARCH_PATH, &block
  end

  def self.for_each_schema &block
    with_root_tenant_schema &block

    if connection.table_exists?('tenants')
      self.all.each do |tenant|
        tenant.scope_schema &block
      end
    else
      Rails.logger.info "Warning: table tenants does not exist, create it using the create_tenants migration."
    end
  end

  # ===== Utilities =====

  def self.schema_tool
    Together::SchemaTool.new(connection)
  end

  def self.tenant_schema_path
    File.join(Rails.application.config.paths["db"].first, 'tenant_schema.rb')
  end

  def self.tenant_schema_file_exists?
    File.exist? tenant_schema_path
  end

  def schema_tool
    self.class.schema_tool
  end
end