require "rails_helper"

describe Calculator::Breakpoints do
  subject { service.call }

  let(:service) { described_class.new(arguments) }

  context "no arguments passed" do
    let(:service) { described_class.new }
    it "raises error" do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context "argumens passed" do
    subject { service.call.success }

    context "Zealot vs. Ling" do
      let(:arguments) do
        { hitpoints: 35, damage: 8, bonus: 1, attacks: 2, armor: 0 }
      end

      context "0 attack Zealot, 0 armor Ling" do
        it "takes 3 hits" do
          expect(subject[0, 0]).to eq 3
        end
      end

      context "1 attack Zealot, 0 armor Ling" do
        it "takes 2 hits" do
          expect(subject[1, 0]).to eq 2
        end
      end

      context "1 attack Zealot, 1 armor Ling" do
        it "takes 3 hits" do
          expect(subject[1, 1]).to eq 3
        end
      end

      context "0 attack Zealot, 3 armor Ling" do
        it "takes 4 hits" do
          expect(subject[0, 3]).to eq 4
        end
      end
    end
  end
end
