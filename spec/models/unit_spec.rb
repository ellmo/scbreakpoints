require "rails_helper"

describe Unit, type: :model do
  describe "#coefficient" do
    subject { unit.coefficient target }

    context "zealot attacks zergling" do
      let(:unit)   { Unit.find "zealot" }
      let(:target) { Unit.find "zergling" }

      it { is_expected.to eq 1.0 }
    end

    context "zealot attacks mutalisk" do
      let(:unit)   { Unit.find "zealot" }
      let(:target) { Unit.find "mutalisk" }

      it { is_expected.to eq nil }
    end

    context "dragoon attacks mutalisk" do
      let(:unit)   { Unit.find "dragoon" }
      let(:target) { Unit.find "mutalisk" }

      it { is_expected.to eq 0.5 }
    end
  end
end
