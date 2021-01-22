require "rails_helper"

describe Unit, type: :model do
  describe "#coefficient" do
    subject { red.coefficient }

    before { red.target!(blue) }

    context "zealot attacks zergling" do
      let(:red)  { Unit.find "zealot" }
      let(:blue) { Unit.find "zergling" }

      it { is_expected.to eq 1.0 }
    end

    context "zealot attacks mutalisk" do
      let(:red)  { Unit.find "zealot" }
      let(:blue) { Unit.find "mutalisk" }

      it { is_expected.to eq nil }
    end

    context "dragoon attacks mutalisk" do
      let(:red)  { Unit.find "dragoon" }
      let(:blue) { Unit.find "mutalisk" }

      it { is_expected.to eq 0.5 }
    end
  end
end
