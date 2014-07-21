class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    add_index :users, :authentication_token
    remove_column :users, :login_token, :string
    rename_column :users, :login_token_expires_at, :authentication_token_expires_at
  end
end
