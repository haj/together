require 'devise'
require 'active_model_serializers'

module Together
  extend ActiveSupport::Autoload

  autoload :SchemaTool
  autoload :ActionControllerExtensions
  
end

require 'together/engine'
