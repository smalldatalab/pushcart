object @swap_category

attributes :id,
           :name

node(:swaps_count) { |cat| cat.swaps.count }