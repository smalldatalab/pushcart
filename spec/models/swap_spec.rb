require 'spec_helper'

describe Swap do

  describe "#vendor_search_link" do

    [
      ['Fresh Direct', 'http://www.freshdirect.com/search.jsp?searchParams=myx+fusions+moscato+coconut'],
      ['Instacart', 'https://www.instacart.com/store/whole-foods/search/myx%20fusions%20moscato%20coconut'],
      ['Peapod', 'http://www.peapod.com/processShowBrowseAisles.jhtml'],
      ['unknown', 'https://www.google.com/search?q=unknown+myx+fusions+moscato+coconut']
    ].each do |test_set|
      it "should return the right link for #{test_set[0]}" do
        swap = Swap.new(name: 'MYX Fusions Moscato & Coconut')
        swap.vendor_search_link(test_set[0]).should == test_set[1]
      end
    end

  end

end
