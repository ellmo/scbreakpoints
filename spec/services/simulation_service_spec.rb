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
    let(:zealot) { Unit.find(:zealot) }
    let(:ling) { Unit.find(:ling) }

    let(:arguments) { { blue: Unit.find(:ling), red: Unit.find(:zealot) } }
    let(:success)   { { winner: zealot, hits: 3, against: 6 } }

    it "is a success" do
      expect(subject).to be_success
    end

    it "Zealot wins in 3 vs 6 strikes" do
      expect(subject.success).to eq success
    end
  end

  context "Goon vs Tank (T)" do
    let(:goon) { Unit.find(:goon) }
    let(:tank) { Unit.find(:tank) }

    let(:arguments) { { blue: goon, red: tank } }
    let(:success)   { { winner: goon, hits: 8, against: 6 } }

    it "is a success" do
      expect(subject).to be_success
    end

    it "Dragoon wins" do
      expect(subject.success).to eq success
    end
  end

  context "Corsair vs Goliath" do
    let(:corsair) { Unit.find(:corsair) }
    let(:goliath) { Unit.find(:goliath) }

    let(:arguments) { { blue: corsair, red: goliath } }
    let(:success)   { { winner: goliath, hits: 12, against: 0 } }

    it "is a success" do
      expect(subject).to be_success
    end

    it "Golaith kills Corsair with no hits taken" do
      expect(subject.success).to eq success
    end
  end

  context "Marine vs Overlord" do
    let(:marine) { Unit.find(:marine) }
    let(:ovie) { Unit.find(:overlord) }

    let(:arguments) { { blue: marine, red: ovie } }
    let(:success)   { { winner: marine, hits: 35, against: 0 } }

    it "is a success" do
      expect(subject).to be_success
    end

    it "Marine kills ovie with no hits taken" do
      expect(subject.success).to eq success
    end
  end

  context "Corsair vs Mutalisk" do
    let(:corsair) { Unit.find(:corsair) }
    let(:muta) { Unit.find(:muta) }

    let(:arguments) { { blue: corsair, red: muta } }
    let(:success)   { { winner: corsair, hits: 42, against: 11 } }

    it "is a success" do
      expect(subject).to be_success
    end

    it "Marine kills ovie with no hits taken" do
      expect(subject.success).to eq success
    end
  end

  # xdescribe "benchmark" do
  #   ling_zealot_arguments = { red: Unit.find(:ling), blue: Unit.find(:zealot) }
  #   goon_tank_arguments = { red: Unit.find(:dragoon), blue: Unit.find(:tank) }

  #   it do
  #     Benchmark.ips do |bench|
  #       bench.report("Ling vs Zealot") do
  #         described_class.new(ling_zealot_arguments).call
  #       end
  #       bench.report("Dragoon vs Tank") do
  #         described_class.new(goon_tank_arguments).call
  #       end

  #       bench.compare!
  #     end
  #   end
  # end
end
