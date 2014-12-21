class Swap < ActiveRecord::Base
  belongs_to :swap_category

  has_many :swap_suggestions
  has_many :items, through: :swap_suggestions

  validates_presence_of :name, :swap_category_id
  validates_uniqueness_of :name

  def vendor_search_link(vendor)
    case vendor
    when 'Fresh Direct'
      "http://www.freshdirect.com/search.jsp?searchParams=#{format_search_string(name)}"
    when 'Peapod'
      'http://www.peapod.com/processShowBrowseAisles.jhtml'
    when 'Instacart'  
      "https://www.instacart.com/store/whole-foods/search/#{format_search_string(name, '%20')}"
    else
      search_string = format_search_string("#{vendor} #{name}")
      "https://www.google.com/search?q=#{search_string}"
    end
  end

  def format_search_string(search_string, space_filler='+')
    search_string.urlize.gsub('-', space_filler)
  end

end
