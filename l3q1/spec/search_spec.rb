require_relative "../lib/search"

RSpec.describe Array do 
  let!(:numbers) { Array(0..20).map {|x| x+1} }

  context "returns Array" do
    
    before { 2.times { numbers.slice!(1) } }

      it "some results are in Array" do
        expect(numbers.search_double).to be_kind_of Array
        expect(numbers.search_double).to_not be_empty
      end

  end

  context "testing results" do
    context "both numbers are at the begin" do
      before { 2.times { numbers.slice!(1) } }

      it "must find both numbers" do
        expect(numbers.search_double).to be_kind_of Array
        expect(numbers.search_double).to eql [2,3]
      end
    end

    context "both numbers are at the end" do
      let!(:numbers) { Array(0..20).map {|x| x+1} }
      before { 2.times { numbers.slice!(-2) } }

      it "must find both numbers" do
        expect(numbers.search_double).to be_kind_of Array
        expect(numbers.search_double).to eql [19,20]
      end
    end

    context "both numbers are at the end" do
      let!(:numbers) { Array(0..20).map {|x| x+1} }
      before { numbers.slice!(3) && numbers.slice!(-3)  }

      it "must find both numbers" do
        expect(numbers.search_double).to be_kind_of Array
        expect(numbers.search_double).to eql [4,19]
      end
    end

    context "wrong sentetnce - numbers are missing" do
      let!(:numbers) { Array(0..20)}
      
      it "must be nil" do
        expect(numbers.search_double).to be_nil
      end
    end



  end
end

