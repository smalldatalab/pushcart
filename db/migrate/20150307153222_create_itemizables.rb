ENABLE_NUTRITIONIX = false

class CreateItemizables < ActiveRecord::Migration
  def change
    add_column :itemizables, :swap_id,  :integer, index: true

    create_table :itemizables do |t|
      t.belongs_to :item
      t.belongs_to :purchase

      t.float      :quantity
      t.float      :total_price
      t.string     :price_breakdown
      t.boolean    :discounted,       default: false
      t.string     :color_code

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        p 'Building itemizables and removing duplicate items...'

        duplicates = 0

        p 'Normalizing names for all items...'
        Item.all.map { |i| i.update_attributes!(name: i.name.strip, description: i.description ? i.description.strip : i.description) }

        p 'Creating itemizables...'
        Item.all.each do |item|
          dup = Item.find_by({name: item.name, description: item.description})

          Itemizable.create(
                            item_id: dup.id,
                            purchase_id: item.purchase_id,
                            quantity: item.quantity,
                            total_price: item.total_price,
                            price_breakdown: item.price_breakdown,
                            discounted: item.discounted,
                            color_code: item.color_code
                           )

          if dup.id != item.id
            duplicates += 1

            item.destroy
          end
        end

        remove_index  :items, :purchase_id
        remove_column :items, :purchase_id,     :integer
        remove_column :items, :quantity,        :float
        remove_column :items, :total_price,     :float
        remove_column :items, :price_breakdown, :string
        remove_column :items, :discounted,      :boolean
        remove_column :items, :color_code,      :string

        remove_column :purchases, :ntx_api_rejected_item_count, :integer
        remove_column :purchases, :category_rejected_item_count, :integer

        p "#{Item.count} items processed, #{Itemizable.count} itemizables created, #{duplicates} duplicate items deleted."
      end

      dir.down do
        p 'Building items from itemizables...'
        p "#{Item.count} items and #{Itemizable.count} itemizables exist."

        add_column :items, :purchase_id,     :integer
        add_index  :items, :purchase_id
        add_column :items, :quantity,        :float
        add_column :items, :total_price,     :float
        add_column :items, :price_breakdown, :string
        add_column :items, :discounted,      :boolean
        add_column :items, :color_code,      :string

        add_column :purchases, :ntx_api_rejected_item_count, :integer
        add_column :purchases, :category_rejected_item_count, :integer

        Itemizable.all.each do |itemizable|
          item = Item.create(
                              name: itemizable.item.name,
                              purchase_id: itemizable.purchase_id,
                              description: itemizable.item.description,
                              category: itemizable.item.category,
                              ntx_api_nutrition_data: itemizable.item.ntx_api_nutrition_data,
                              ntx_api_metadata: itemizable.item.ntx_api_metadata,
                              quantity: itemizable.quantity,
                              total_price: itemizable.total_price,
                              price_breakdown: itemizable.price_breakdown,
                              discounted: itemizable.discounted,
                              color_code: itemizable.color_code
                            )

          unless item
            p itemizable
            p item.errors.full_messages
            raise 'Could not create item!'
          end
        end

        Itemizable.delete_all
        Item.where(purchase_id: nil).delete_all

        p "Now #{Item.count} items and #{Itemizable.count} itemizables exist."
      end
    end


  end
end
