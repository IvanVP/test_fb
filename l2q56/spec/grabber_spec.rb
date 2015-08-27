require_relative "../lib/grabber"

RSpec.describe Grabber do 

  context "has right attributes" do
    let!(:grabber) { Grabber.new('www.rbc.ru', "/tmp") }

    it "has an uri" do
      expect(grabber).to respond_to :uri
      expect(grabber.uri).to eq 'www.rbc.ru'
    end

    it "has a destination dir" do
      expect(grabber).to respond_to :dir
      expect(grabber.dir).to eq './tmp'
    end

    it "has a default host path" do
      expect(grabber).to respond_to :path
      expect(grabber.path).to eq '/'
    end

    it "has an empty hash of images" do
      expect(grabber).to respond_to :images_list
      expect(grabber.images_list).to be_kind_of Hash
      expect(grabber.images_list).to be_empty
    end

  end

  context "can properly get list of images" do
    let!(:grabber) { Grabber.new('www.rbc.ru', "/tmp") }
    before { grabber.get_images }

    it "can parse images" do
      expect(grabber.images_list).to_not be_empty
      expect(grabber.images_list.first[0]).to match /(?:jpg|png|gif)/ 
      expect(grabber.images_list.first[1]).to be_kind_of URI
    end
  end

  context "can save images" do
    let!(:grabber) { Grabber.new('www.rbc.ru', "/tmp") }
    before do 
      grabber.get_images
      grabber.save_images
    end

    it "can save parsed images" do
      expect(Dir.exists?(grabber.dir)).to be true
      expect(Dir.entries(grabber.dir)).to_not be_empty
    end
  end
  
end

