$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "together/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "together"
  s.version     = Together::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Together."
  s.description = "TODO: Description of Together."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0.rc2"
  s.add_dependency "devise", "~> 3.0.0.rc"

  s.add_development_dependency "sqlite3"
end
