require "rails_helper"

describe DataLoaderService do
  subject { service.call }

  let(:service) { described_class.new }
  let(:dump_path) { Rails.root.join("spec/fixtures/data.dump") }

  context "response success" do
    it "is a success" do
      expect(subject).to be_success
    end
  end

  context "response content" do
    let(:expected) { Marshal.load(File.read(dump_path)) } # rubocop:disable Security/MarshalLoad

    it "loaded data equals dump" do
      expect(subject.success).to eq expected
    end
  end
end
