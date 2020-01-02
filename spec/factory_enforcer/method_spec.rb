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

  describe "#match_call_trace?" do
    it "returns true if the call trace matches the method location" do
      call_trace ="#{factory_path}:3:in `build'"
      method = described_class.new(UserFactory, :build, instance_method: true)

      expect(method.match_call_trace?(call_trace)).to eq(true)
    end

    xit "returns false if the call trace does not match the line number of the method location" do
      call_trace ="#{factory_path}:999:in `build'"
      method = described_class.new(UserFactory, :build, instance_method: true)

      expect(method.match_call_trace?(call_trace)).to eq(false)
    end

    it "returns false if the call trace does not match the method name" do
      call_trace ="#{factory_path}:3:in `foo'"
      method = described_class.new(UserFactory, :build, instance_method: true)

      expect(method.match_call_trace?(call_trace)).to eq(false)
    end
  end
end
