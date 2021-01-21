require "rails_helper"

describe Integer do
  describe "#multiples" do
    context "no params" do
      subject { number.multiples }

      let(:number)      { 336 }
      let(:expected_3)  { 1008 }
      let(:expected_20) { 6720 }
      let(:expected_29) { 9744 }

      it do
        expect(subject[3]).to eq expected_3
        expect(subject[20]).to eq expected_20
        expect(subject[29]).to eq expected_29
      end
    end
  end
end
