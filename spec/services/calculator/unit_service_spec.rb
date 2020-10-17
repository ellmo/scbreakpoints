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
    subject { service.call.success }

    let(:data) { DataLoaderService.new.call.success }

    context "Zealot vs. Ling" do
      let(:arguments) do
        { unit: "zealot", target: "zergling", data: data }
      end

      it "returns 4x4 strike matrix" do
        expect(subject).to be_a Matrix
        expect(subject.column_count).to eq 4
        expect(subject.row_count).to eq 4
      end

      it "returns 3 strikes for [0/0] vs [0/0]" do
        expect(subject[0, 0]).to eq 3
      end

      it "returns 2 strikes for [1/0] vs [0/0]" do
        expect(subject[1, 0]).to eq 2
      end

      it "returns 4 strikes for [0/0] vs [0/3]" do
        expect(subject[0, 3]).to eq 4
      end
    end

    context "Goon vs. Ling" do
      let(:arguments) do
        { unit: "dragoon", target: "zergling", data: data }
      end

      it "returns 4x4 strike matrix" do
        expect(subject).to be_a Matrix
        expect(subject.column_count).to eq 4
        expect(subject.row_count).to eq 4
      end

      it "returns 3 strikes for [0/0] vs [0/0]" do
        expect(subject[0, 0]).to eq 4
      end

      it "returns 2 strikes for [1/0] vs [0/0]" do
        expect(subject[1, 0]).to eq 4
      end

      it "returns 2 strikes for [2/0] vs [0/0]" do
        expect(subject[2, 0]).to eq 3
      end

      it "returns 4 strikes for [0/0] vs [0/3]" do
        expect(subject[0, 3]).to eq 5
      end
    end

    context "Goon vs. Goon" do
      let(:arguments) do
        { unit: "dragoon", target: "dragoon", data: data }
      end

      it "returns 4x4 strike matrix" do
        expect(subject).to be_a Matrix
        expect(subject.column_count).to eq 4
        expect(subject.row_count).to eq 4
      end

      it "returns 10 strikes for [0/0] vs [0/0]" do
        expect(subject[0, 0]).to eq 10
      end

      it "returns 9 strikes for [1/0] vs [0/0]" do
        expect(subject[1, 0]).to eq 9
      end

      it "returns 12 strikes for [0/0] vs [0/3]" do
        expect(subject[0, 3]).to eq 12
      end
    end
  end
end
