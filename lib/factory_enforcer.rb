# frozen_string_literal: true

require "factory_enforcer/exceptions"
require "factory_enforcer/version"
require "factory_enforcer/method"

module FactoryEnforcer
  def new(*args, &block)
    if should_enforce_factory_usage?
      factory_class = UserFactory

      factory_methods = Method.all_from_class(factory_class)
      factory_caller_patterns = factory_methods.map(&:caller_pattern)

      called_from_factory_method = caller.any? do |call_trace|
        factory_caller_patterns.any? do |format_pattern|
          format_pattern.match?(call_trace)
        end
      end

      unless called_from_factory_method
        raise FactoryNotUsed.new(self.class, factory_class)
      end
    end

    super
  end

  def should_enforce_factory_usage?
    true
  end
end
