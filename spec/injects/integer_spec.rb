require "rails_helper"
require "benchmark/ips"

describe Integer do
  describe "#multiples" do
    context "no params" do
      subject { number.multiples }

      let(:number) { 336 }

      it "snippet" do
        subject
      end
    end

    describe "comparison" do
      describe "results" do
        it "are the same" do
          Array.new(100) { rand(1000) }.each do |integer|
            expect(integer.multiples).to eq integer.multiples2
          end
        end
      end
    end

    describe "benchmark" do
      it do
        integer = rand(1000)
        puts "for #{integer}"

        Benchmark.ips do |bench|
          bench.report("#multiples") { integer.multiples }
          bench.report("#multiples2") { integer.multiples2 }

          bench.compare!
        end
      end
    end
  end
end
