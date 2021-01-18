require "rails_helper"

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
end
