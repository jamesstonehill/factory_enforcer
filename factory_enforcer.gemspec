# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "factory_enforcer/version"

Gem::Specification.new do |spec|
  spec.name          = "factory_enforcer"
  spec.version       = FactoryEnforcer::VERSION
  spec.authors       = ["James Stonehill"]
  spec.email         = ["jamesstonehill@gmail.com"]

  spec.summary       = "Enforce usage of the factory pattern with factory_enforcer"
  spec.description   = "Enforce usage of the factory pattern with factory_enforcer"
  spec.homepage      = "https://github.com/jamesstonehill/factory_enforcer"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
