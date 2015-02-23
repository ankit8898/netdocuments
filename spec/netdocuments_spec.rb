require "spec_helper"

describe Netdocuments do
  describe "#configure" do
    before do
      Netdocuments.configure do |config|
        config.cabinet_id = 'abc'
      end
    end

    it "returns an array with 10 elements" do

      folder = Netdocuments::Folder.new


      expect(folder.cabinet_id).to eq('abc')
    end
  end
end
