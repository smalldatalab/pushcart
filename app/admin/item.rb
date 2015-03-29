ActiveAdmin.register Item do
  permit_params :swap_id
  actions :all, except: [:destroy]

  index do
    selectable_column
    id_column

    column :name
    column :purchase
    column :description
    column :price_breakdown
    column :category
    column :total_price
    column :quantity
    column :discounted
    column :created_at

    actions
  end

  form do |f|
    f.inputs "Make a swap" do
      f.input :swap
    end
    f.actions
  end

  csv do
    column :id
    column :name
    column :description
    column :category
    column :created_at
    column :updated_at

    [:item_name, :brand_name, :item_description, :updated_at, :nf_ingredient_statement, :nf_water_grams, :nf_calories, :nf_calories_from_fat, :nf_total_fat, :nf_saturated_fat, :nf_trans_fatty_acid, :nf_polyunsaturated_fat, :nf_monounsaturated_fat, :nf_cholesterol, :nf_sodium, :nf_total_carbohydrate, :nf_dietary_fiber, :nf_sugars, :nf_protein, :nf_vitamin_a_dv, :nf_vitamin_c_dv, :nf_calcium_dv, :nf_iron_dv, :nf_refuse_pct, :nf_servings_per_container, :nf_serving_size_qty, :nf_serving_size_unit, :nf_serving_weight_grams, :allergen_contains_milk, :allergen_contains_eggs, :allergen_contains_fish, :allergen_contains_shellfish, :allergen_contains_tree_nuts, :allergen_contains_peanuts, :allergen_contains_wheat, :allergen_contains_soybeans, :allergen_contains_gluten].each do |nutr|
      column(nutr.to_s) { |item| item.ntx_api_nutrition_data[nutr.to_s] unless item.ntx_api_nutrition_data.blank? }
    end
  end

end
