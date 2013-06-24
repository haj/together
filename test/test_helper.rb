# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'minitest/spec'

Rails.backtrace_cleaner.remove_silencers!

# load factories (not found 'cause engine)
Dir[Rails.root + "../factories/**/*.rb"].each { |f| require f }

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end