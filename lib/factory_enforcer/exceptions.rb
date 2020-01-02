# frozen_string_literal: true

module FactoryEnforcer
  class FactoryNotUsed < StandardError
    def initialize(class_name, factory_class)
      super(
        "Factory usage is enforced for the #{class_name} class. You must use the #{factory_class} to contstruct #{class_name} instances"
      )
    end
  end

  class FactoryClassNotFound < StandardError
    def initialize(class_name)
      super(
        "Unable to find factory for the #{class_name} class. Either define a #{class_name}Factory or define a #{class_name}.factory_class method that returns the factory for the #{class_name} class."
      )
    end
  end
end
