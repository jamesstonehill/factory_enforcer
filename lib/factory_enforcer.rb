# frozen_string_literal: true

require "factory_enforcer/exceptions"
require "factory_enforcer/version"
require "factory_enforcer/method"

module FactoryEnforcer
  def new(*args, &block)
    if should_enforce_factory_usage?
      factory_methods = Method.all_from_class(factory_class)

      called_from_factory_method = caller.any? do |call_trace|
        factory_methods.any? do |factory_method|
          factory_method.match_call_trace?(call_trace)
        end
      end

      unless called_from_factory_method
        raise FactoryNotUsed.new(name, factory_class)
      end
    end

    super
  end

  def should_enforce_factory_usage?
    true
  end

  def factory_class
    @factory_class ||= Kernel.const_get(name + "Factory")
  rescue NameError
    raise FactoryClassNotFound, name
  end
end
