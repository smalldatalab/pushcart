class AddColorCodeToItems < ActiveRecord::Migration
  def change
    add_column :items, :color_code, :string
    add_column :coaches, :name, :string

    reversible do |dir|
      dir.up do
        Coach.all.map { |c| c.update(name: c.email.gsub(/@.*$/, '')) unless c.name }
      end
    end
  end
end
