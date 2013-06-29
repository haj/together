require 'devise'

module Together
  extend ActiveSupport::Autoload

  autoload :SchemaTool
end

require 'together/engine'
