require "rails_helper"

describe Unit, type: :model do
  describe "#coefficient" do
    subject { red.coefficient }

    before { red.target!(blue) }

    context "zealot attacks zergling" do
      let(:red)  { described_class.find "zealot" }
      let(:blue) { described_class.find "zergling" }

      it { is_expected.to eq 1.0 }
    end

    context "zealot attacks mutalisk" do
      let(:red)  { described_class.find "zealot" }
      let(:blue) { described_class.find "mutalisk" }

      it { is_expected.to eq nil }
    end

    context "dragoon attacks mutalisk" do
      let(:red)  { described_class.find "dragoon" }
      let(:blue) { described_class.find "mutalisk" }

      it { is_expected.to eq 0.5 }
    end
  end
end
