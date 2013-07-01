# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# load factories (not found 'cause engine)
Dir[Rails.root + "../factories/**/*.rb"].each { |f| require f }

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def assert_same_set *collections
    assert_equal *collections.map(&:to_set)
  end
end