class WeeklyEmailDigester

  def initialize(user, last_day_of_week, comparison_categories_breakdown=nil)
    @user = user

    set_reporting_period(last_day_of_week)

    @purchases = purchases_for_week

    if @purchases.blank?
      return false
    else
      @items = @purchases.map { |pur| pur.items.to_a }.flatten

      build_categories_breakdown
      categorize_items
      merge_comparison_digest(comparison_categories_breakdown) if comparison_categories_breakdown

      return true
    end
  end

  def purchases
    @purchases
  end

  def start_date
    @start_date
  end

  def end_date
    @end_date
  end

  def items
    @items
  end

  def items_with_categories
    @items_with_categories
  end

  def total_price
    @purchases.map { |pur| pur.total_price }.inject(:+)
  end

  def build_categories_breakdown
    @categories_breakdown = blank_categories_breakdown

    @items.each do |i|
      @categories_breakdown[i.filtered_category][:count] += 1
      @categories_breakdown[i.filtered_category][:servings] += i.servings_total
      @categories_breakdown[:total] += 1
      @categories_breakdown[:servings_total] += i.servings_total
      @categories_breakdown[:servings_max] = @categories_breakdown[i.filtered_category][:servings] if @categories_breakdown[i.filtered_category][:servings] > @categories_breakdown[:servings_max]
    end

    percentages = []

    CategoryDigester.ruminate.each do |cat|
      percent = (@categories_breakdown[cat][:servings].to_f/@categories_breakdown[:servings_total].to_f)*100
      @categories_breakdown[cat][:percent] = percent
      percentages << percent
    end

    @categories_breakdown[:high_percent] = percentages.sort.pop

  end

  def categories_breakdown
    @categories_breakdown
  end

  def merge_comparison_digest(comp_breakdown)
    largest_prior_reference = 0

    CategoryDigester.ruminate.each do |cat|
      @categories_breakdown[cat][:prior_servings] = comp_breakdown[cat][:servings]
      largest_prior_reference = comp_breakdown[cat][:servings] if comp_breakdown[cat][:servings] > largest_prior_reference
    end

    @categories_breakdown[:prior_servings_total] = largest_prior_reference
    @categories_breakdown[:reference_servings_max] = largest_prior_reference > @categories_breakdown[:servings_max] ? largest_prior_reference : @categories_breakdown[:servings_max]    
  end

private

  def set_reporting_period(last_day_of_week)
    @end_date   = last_day_of_week.end_of_day
    @start_date = @end_date - 7.days
  end

  def purchases_for_week
    return @user.purchases.where(created_at: @start_date..@end_date).order('created_at ASC')
  end

  def blank_categories_breakdown
    categories_breakdown = { total: 0, servings_total: 0, servings_max: 0 }
    CategoryDigester.ruminate.map { |c| categories_breakdown[c] = { count: 0, servings: 0 } }
    return categories_breakdown
  end

  def categorize_items
    @items_with_categories = {}
    CategoryDigester.ruminate.map { |c| @items_with_categories[c] = [] }

    @items.each do |i|
      # Sort items into categories and combines quantities for items that have same name
      if @items_with_categories[i.filtered_category].empty?
        @items_with_categories[i.filtered_category] << i
      else 
        duplicate = find_and_increment_duplicate_items(@items_with_categories[i.filtered_category], i)

        @items_with_categories[i.filtered_category] << i unless duplicate
      end
    end
  end

  def find_and_increment_duplicate_items(items_array, item)
    items_array.each do |candidate|
      if candidate.name == item.name && !candidate.quantity.nil?
        candidate.quantity += 1
        return candidate 
      end
    end
    return false
  end

end
