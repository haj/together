# desc "Explaining what the task does"
# task :together do
#   # Task goes here
# end

namespace :tenants do
  db_namespace = namespace :db do
    desc 'Checks if using postgresql'
    task :assert_supported => [:environment] do
      Tenant.schema_tool.assert_supported
    end

    namespace :schema do
      desc 'Create a db/schema.rb file that can be portably used against any DB supported by AR'
      task :dump => [:environment, 'db:load_config', 'tenants:db:assert_supported'] do
        require 'active_record/schema_dumper'
        filename = ENV['TENANT_SCHEMA'] || File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'tenant_schema.rb')
        File.open(filename, "w:utf-8") do |file|
          Tenant.with_root_tenant_schema do
            ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
          end
        end
        db_namespace['schema:dump'].reenable
      end

      desc 'Load a schema.rb file into the database'
      task :load => [:environment, 'db:load_config', 'tenants:db:assert_supported'] do
        file = ENV['TENANT_SCHEMA'] || File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'tenant_schema.rb')
        if File.exists?(file)
          Tenant.for_each_schema do
            load(file)
          end
        else
          abort %{#{file} doesn't exist yet. Run `rake db:migrate` to create it, then try again. If you do not intend to use a database, you should instead alter #{Rails.root}/config/application.rb to limit the frameworks that will be loaded.}
        end
      end
    end
  end
end

joined_tasks = %w(db:schema:load db:schema:dump)

joined_tasks.each do |task_name|
  prefix = if defined?(ENGINE_PATH) then 'app:' else ''; end
  Rake::Task[prefix + task_name].enhance(["tenants:#{task_name}"])
end