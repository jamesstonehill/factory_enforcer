# frozen_string_literal: true

require_relative "./user_factory"

class User
  extend FactoryEnforcer

  def self.factory_class
    UserFactory
  end
end
