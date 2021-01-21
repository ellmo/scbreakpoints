require "rails_helper"
require "benchmark/ips"

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
    let(:arguments) { { red: Unit.find(:ling), blue: Unit.find(:zealot), report: true } }

    it "is a success" do
      expect(subject).to be_success
    end

    it "Zealot wins in 3 vs 6 strikes" do
      expect(subject.success).to eq "zealot wins with 3 strikes against 6"
    end
  end

  context "Goon vs Tank (tank mode)" do
    let(:arguments) { { red: Unit.find(:goon), blue: Unit.find(:tank), report: true } }

    it "is a success" do
      expect(subject).to be_success
    end

    it "Tank wins in 7 vs 7 strikes" do
      expect(subject.success).to eq "siege_tank_tank_mode wins with 7 strikes against 7"
    end
  end

  describe "benchmark" do
    ling_zealot_arguments = { red: Unit.find(:ling), blue: Unit.find(:zealot) }
    goon_tank_arguments = { red: Unit.find(:dragoon), blue: Unit.find(:tank) }

    it do
      Benchmark.ips do |bench|
        bench.report("Ling vs Zealot") do
          described_class.new(ling_zealot_arguments).call
        end
        bench.report("Dragoon vs Tank") do
          described_class.new(goon_tank_arguments).call
        end

        bench.compare!
      end
    end
  end
end
