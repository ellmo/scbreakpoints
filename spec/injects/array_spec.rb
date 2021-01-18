require "rails_helper"
require "benchmark/ips"

describe Array do
  describe "#each_multiple" do
    subject { array.each_multiple(value) &block }

    context "return_result = false" do
      context "elements are ONLY numerical" do
        let(:array) { [1.25, 2.18] }
        let(:value) { 60 }
        let(:block) { ->(element) { element } }

        it "does something" do
          subject
        end
      end
    end
  end

  describe "#each_period" do
    subject { array.each_period(value) &block }

    context "return_result = false" do
      context "elements are ONLY numerical" do
        let(:array) { [BigDecimal("1.25"), BigDecimal("2.18")] }
        let(:value) { 60 }
        let(:block) { ->(element) { element } }

        it "does something" do
          subject
        end
      end
    end
  end

  describe "comparative benchmark" do
    Benchmark.ips do |bench|
      bench.report("BigDecimal") { [BigDecimal("1.25"), BigDecimal("2.18")].each_period(1000) }
      bench.report("Float") { [1.25, 2.18].each_multiple(1000) }

      bench.compare!
    end
  end
end
