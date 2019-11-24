# frozen_string_literal: true

class UserFactory
  def build
    User.new
  end

  def self.build
    User.new
  end
end
