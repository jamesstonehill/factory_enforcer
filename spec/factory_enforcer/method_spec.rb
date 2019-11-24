# frozen_string_literal: true

require_relative "../support/user_factory"

RSpec.describe FactoryEnforcer::Method do
  "/Users/James/.rbenv/versions/2.4.6/lib/ruby/2.4.0/irb.rb:627:in `signal_status'"
  let(:factory_path) { File.expand_path("spec/support/user_factory.rb") }

  describe ".all_from_class" do
    it "creates a Method instance for each class and instance method for a given class" do
      expect(FactoryEnforcer::Method).to receive(:new).with(UserFactory, :build, instance_method: true).and_call_original
      expect(FactoryEnforcer::Method).to receive(:new).with(UserFactory, :build, instance_method: false).and_call_original

      methods = described_class.all_from_class(UserFactory)

      expect(methods.count).to eq(2)
    end
  end

  describe "#caller_pattern" do
    it "returns the instance method's location in the format that Kernel.caller does" do
      method = described_class.new(UserFactory, :build, instance_method: true)
      expect(method.caller_pattern).to match("#{factory_path}:3:in `build'")
    end

    it "returns the class method's location in the format that Kernel.caller does" do
      method = described_class.new(UserFactory, :build, instance_method: false)
      expect(method.caller_pattern).to match("#{factory_path}:7:in `build'")
    end

    it "does not match with the caller" do
      method = described_class.new(UserFactory, :build, instance_method: false)
      user_class_path = File.expand_path("spec/support/user.rb")
      expect(method.caller_pattern).not_to match("#{user_class_path}:7:in `new'")
    end
  end
end
