require 'spec_helper'

describe MailerHelper do

  describe "#vendor_search_link" do

    [
      ['Fresh Direct', 'https://www.freshdirect.com/search.jsp?searchParams=myx+fusions+moscato+coconut'],
      ['Instacart', 'https://www.instacart.com/store/whole-foods/search/myx%20fusions%20moscato%20coconut'],
      ['Peapod', 'http://www.peapod.com'],
      ['unknown', 'https://www.google.com/search?q=unknown+myx+fusions+moscato+coconut']
    ].each do |test_set|
      it "should return the right link for #{test_set[0]}" do
        vendor_search_link('MYX Fusions Moscato & Coconut', test_set[0]).should == test_set[1]
      end
    end

  end
    
end