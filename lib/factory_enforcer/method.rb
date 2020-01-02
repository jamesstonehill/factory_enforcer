# frozen_string_literal: true

module FactoryEnforcer
  class Method
    def self.all_from_class(klass)
      instance_methods = klass.instance_methods(false).map do |method_name|
        new(klass, method_name, instance_method: true)
      end
      class_methods = klass.methods(false).map do |method_name|
        new(klass, method_name, instance_method: false)
      end

      instance_methods + class_methods
    end

    def initialize(klass, method_name, instance_method:)
      @method_name = method_name

      @method = if instance_method
                  klass.instance_method(method_name)
                else
                  klass.method(method_name)
                end
    end

    def match_call_trace?(trace)
      if in_irb?
        return true if irb_pattern.match?(trace)
      end

      caller_pattern.match?(trace)
    end

    private

    def caller_pattern
      /^#{location[0]}:\d+:in\s`#{@method_name}'$/
    end

    def in_irb?
      defined?(IRB)
    end

    def irb_pattern
      /^\(irb\):\d+:in\s`#{@method_name}'$/
    end

    def location
      @method.source_location
    end
  end
end
