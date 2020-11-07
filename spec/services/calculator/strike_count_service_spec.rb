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

  context "pure Zealot vs. pure Ling" do
    let(:arguments) do
      { unit: "zealot", target: "zergling" }
    end

    it "returns 3 strikes" do
      expect(subject.success).to eq 3
    end
  end

  context "pure Zealot vs. [0/3] Ling" do
    let(:arguments) do
      { unit: "zealot", target: "zergling", bonus_armor: 3 }
    end

    it "returns 4 strikes" do
      expect(subject.success).to eq 4
    end
  end

  context "pure Ling vs. pure Marine" do
    let(:arguments) do
      { unit: "zergling", target: "marine" }
    end

    it "returns 3 strikes" do
      expect(subject.success).to eq 8
    end
  end

  context "pure Sieged Siege Tank vs. pure Marine" do
    let(:arguments) do
      { unit: "siege_tank_siege_mode", target: "marine" }
    end

    it "returns 2 strikes" do
      expect(subject.success).to eq 2
    end
  end

  context "pure Siege Tank vs. pure Goon" do
    let(:arguments) do
      { unit: "siege_tank_tank_mode", target: "dragoon" }
    end

    it "returns 7 strikes" do
      expect(subject.success).to eq 7
    end
  end

  context "[1/0] Siege Tank vs. [0/1] Zealot" do
    let(:arguments) do
      { unit: "siege_tank_tank_mode", target: "zealot", bonus_attack: 1, bonus_armor: 1 }
    end

    it "returns 10 strikes" do
      expect(subject.success).to eq 9
    end
  end

  context "pure Siege Tank vs. pure Hydralisk" do
    let(:arguments) do
      { unit: "siege_tank_tank_mode", target: "hydralisk" }
    end

    it "returns 4 strikes" do
      expect(subject.success).to eq 4
    end
  end

  context "pure Siege Tank vs. [0/2] Hydralisk" do
    let(:arguments) do
      { unit: "siege_tank_tank_mode", target: "hydralisk", bonus_armor: 2 }
    end

    it "returns 4 strikes" do
      expect(subject.success).to eq 4
    end
  end
end
