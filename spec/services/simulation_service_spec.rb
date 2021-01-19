require "rails_helper"

describe SimulationService do
  subject { service.call }

  let(:service) { described_class.new(arguments) }

  context "no arguments passed" do
    let(:service) { described_class.new }

    it "raises error" do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context "Zergling vs Zealot" do
    let(:arguments) { { red: Unit.find(:ling), blue: Unit.find(:zealot) } }

    it "is a success" do
      expect(subject).to be_success
    end
  end
end
