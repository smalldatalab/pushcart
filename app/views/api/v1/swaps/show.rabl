object @swap

attributes :id,
           :name

node(:freshdirect_link) { |swap| swap.vendor_search_link('Fresh Direct') }
node(:peapod_link) { |swap| swap.vendor_search_link('Peapod') }
node(:instacart_link) { |swap| swap.vendor_search_link('Instacart') }

child :swap_category do
  extends 'api/v1/swap_categories/show'
end