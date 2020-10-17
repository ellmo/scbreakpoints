require "rails_helper"

describe Calculator::UnitService do
  subject { service.call }

  let(:service) { described_class.new(arguments) }

  context "no arguments passed" do
    let(:service) { described_class.new }
    it "raises error" do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context "arguments passed" do
    let(:data) { DataLoaderService.new.call.success }

    context "Zealot vs. Ling" do
      let(:arguments) do
        { unit: "zealot", target: "zergling", data: data }
      end

      it "returns 3 strikes" do
        expect(subject.success).to eq 3
      end
    end

    context "Goon vs. Goon" do
      let(:arguments) do
        { unit: "dragoon", target: "dragoon", data: data }
      end

      it "returns 10 strikes" do
        expect(subject.success).to eq 10
      end
    end
  end
end
