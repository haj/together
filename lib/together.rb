require 'devise'
require 'active_model_serializers'
require 'pg'

# ===== Interface =====

require 'jquery-rails'
require 'bootstrap-sass'
require 'angular-rails'
require 'angularjs-rails-resource'
require 'haml'

module Together
  extend ActiveSupport::Autoload

  autoload :SchemaTool
  autoload :ActionControllerExtensions
  
end

require 'together/engine'
