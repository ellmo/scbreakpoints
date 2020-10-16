require "rails_helper"

describe Calculator::StrikeCountService do
  subject { service.call }

  let(:service) { described_class.new(arguments) }

  context "no arguments passed" do
    let(:service) { described_class.new }
    it "raises error" do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context "pure Zealot vs pure Ling arguments passed" do
    let(:arguments) do
      { hitpoints: 35, damage: 8, attacks: 2, armor: 0 }
    end


  end
end
