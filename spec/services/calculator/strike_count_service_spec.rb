require "rails_helper"

describe Calculator::StrikeCountService do
  subject { service.call }

  let(:service) { described_class.new(arguments) }

  context "no arguments passed" do
    let(:service) { described_class.new }
    it "raises error" do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context "pure Zealot vs. pure Ling arguments" do
    let(:arguments) do
      { hitpoints: 35, damage: 8, attacks: 2, armor: 0 }
    end

    it "is a success" do
      expect(subject).to be_success
    end

    it "returns 3 strikes" do
      expect(subject.success).to eq 3
    end
  end

  context "pure Ling vs. pure Marine arguments" do
    let(:arguments) do
      { hitpoints: 40, damage: 5, attacks: 1, armor: 0 }
    end

    it "returns 3 strikes" do
      expect(subject.success).to eq 8
    end
  end

  context "pure Sieged Siege Tank vs. pure Marine" do
    let(:arguments) do
      { hitpoints: 40, damage: 70, attacks: 1, armor: 0, type: "explosive" }
    end

    it "returns 2 strikes" do
      expect(subject.success).to eq 2
    end
  end
end
