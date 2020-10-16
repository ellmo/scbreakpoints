require "rails_helper"

describe DataLoaderService do
  subject { service.call }

  let(:service) { described_class.new }

  context "response success" do
    it "is a success" do
      expect(subject).to be_success
    end
  end
end
