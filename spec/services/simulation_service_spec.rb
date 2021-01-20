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
    let(:arguments) { { red: Unit.find(:ling), blue: Unit.find(:zealot) } }

    it "is a success" do
      expect(subject).to be_success
    end

    it "Zealot wins in 4 vs a gazzilion of attacks" do
      expect(subject.success).to eq "zealot wins with 3 strikes against 7"
    end

    describe "benchmark" do
      it do
        Benchmark.ips do |bench|
          bench.report("Ling vs Zealot") { subject }

          # bench.compare!
        end
      end
    end
  end
end
