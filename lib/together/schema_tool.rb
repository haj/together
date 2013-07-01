module Together
  class SchemaTool
    attr_reader :connection

    def initialize connection
      @connection = connection
    end

    def search_path
      connection.schema_search_path
    end

    def set_search_path *names
      connection.schema_search_path = names.join(',')
    end

    def with_search_path *names
      original_search_path = search_path
      set_search_path *names
      yield
    ensure
      connection.schema_search_path = original_search_path
    end

    def create_schema(name)
      sql = %{CREATE SCHEMA "#{name}"}
      connection.execute sql
    end

    def delete_schema(name)
    end

    def schemas
      sql = "SELECT nspname FROM pg_namespace WHERE nspname !~ '^pg_.*'"
      connection.query(sql).flatten
    end

    def schema_exists? name
      schemas.include?(name)
    end

    def assert_supported
      unless connection.adapter_name == "PostgreSQL"
        raise NotImplementedError, "Together requires that you use postgresql for this connection"
      end
    end
  end
end