require "rails_helper"

describe BreakpointCalculatorService do
  subject { service.call }

  let(:service) { described_class.new(arguments) }

  context "no arguments passed" do
    let(:service) { described_class.new }
    it "raises error" do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context "ZvP passed" do
    let(:arguments) { { race: :zerg, opponent: :protoss } }

    it "is a success" do
      expect(subject).to be_success
    end
  end
end
