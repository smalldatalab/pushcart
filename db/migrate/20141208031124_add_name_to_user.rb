class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    
    reversible do |dir|
      dir.up do
        User.all.map { |u| u.update(name: u.endpoint_email) }
      end
    end
  end
end
