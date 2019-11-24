# frozen_string_literal: true

module FactoryEnforcer
  class FactoryNotUsed < StandardError
    def initialize(class_name, factory_class)
      super(
        "Factory usage is enfoced for the #{class_name} class. You must use the #{factory_class} to contstruct #{class_name} instances"
      )
    end
  end
end
