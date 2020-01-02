# frozen_string_literal: true

require_relative "./support/user"
require_relative "./support/user_factory"

RSpec.describe FactoryEnforcer do
  it "has a version number" do
    expect(FactoryEnforcer::VERSION).not_to be nil
  end

  it "throws an error if a User is not created within the UserFactory" do
    expect { User.new }.to raise_error(FactoryEnforcer::FactoryNotUsed)
  end

  it "does not throw an error if the user is created within the UserFactory" do
    expect { UserFactory.build }.not_to raise_error
  end

  it "is possible to disable the FactoryEnforcer by overwriding the should_enforce_factory_usage? method" do
    allow(User).to receive(:should_enforce_factory_usage?).and_return(false)

    expect { User.new }.not_to raise_error
  end

  it "raises an error if it can not find a factory for the class" do
    class ClassWithoutFactory
      extend FactoryEnforcer
    end

    expect do
      ClassWithoutFactory.new
    end.to raise_error(FactoryEnforcer::FactoryClassNotFound)
  end

  it "allows you to define a custom factory class" do
    class ClassWithCustomFactory
      extend FactoryEnforcer

      def self.factory_class
        CustomFactory
      end
    end

    class CustomFactory
      def self.build
        ClassWithCustomFactory.new
      end
    end

    CustomFactory.build
  end
end
