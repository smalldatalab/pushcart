class CategoryDigester

  def self.chew(category_name, item_name=nil)
    case category_name
    when /egg/i
      if item_name.nil? || item_name =~ /egg/i
        :protein
      else
        :dairy
      end
    when /dairy/i
      :dairy
    when /produce/i
      :vegetables
    when /veget/i
      :vegetables
    when /fruit/i
      :fruit
    when /bakery/i
      :grain
    when /breakf/i
      :grain
    when /pasta/i
      :grain
    when /meat/i
      :protein
    when /deli/i
      :protein
    when /seafood/i
      :protein
    when /beverage/i
      :fat
    when /snack/i
      :fat
    when /condiment/i
      :fat
    when /prepared/i
      :prepared_meals
    when /meal/i
      :prepared_meals
    else
      :uncategorized
    end
  end

  def self.ruminate
    [:dairy, :vegetables, :fruit, :grain, :protein, :fat, :uncategorized]
  end

end