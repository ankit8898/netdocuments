module Netdocuments
  describe Configuration do
    describe "cabinet_id" do
      it "default value is abc" do
        expect(Configuration.new.cabinet_id).to eq 'abc'
      end
    end

    describe "#cabinet_id=" do
      it "can set value" do
        config = Configuration.new
        config.cabinet_id = 'Hoola!'
        expect(config.cabinet_id).to eq('Hoola!')
      end
    end
  end

end
