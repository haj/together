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
      connection.schema_search_path = names.map { |name| connection.quote_column_name(name) }.join(',')
    end

    # Returns search path names array without quotes
    def search_path_names
      search_path.split(',').map {|name| name.gsub(/(\A\"|\"\Z)/, '') } # TODO: maybe find more elegant way?
    end

    def with_search_path *names
      original_search_path = search_path
      set_search_path *names
      yield
    ensure
      connection.schema_search_path = original_search_path
    end

    def create_schema(name)
      sql = %{CREATE SCHEMA #{connection.quote_column_name(name)}}
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

    VALID_HOSTNAME_PATTERN = /\A(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])\Z/

    def self.name_for_domain domain
      raise ArgumentError, "invalid domain name" unless domain =~ VALID_HOSTNAME_PATTERN

      domain.gsub('.', '_')
    end

  end
end