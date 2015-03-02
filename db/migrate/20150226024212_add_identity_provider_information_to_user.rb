class AddIdentityProviderInformationToUser < ActiveRecord::Migration
  def change
    add_column :users, :inbox_api_token, :json
    add_column :users, :identity_provider, :string
    add_column :users, :inbox_last_scraped, :datetime

    add_column :messages, :inbox_metadata, :json
    add_column :messages, :date, :datetime
    add_column :messages, :source, :string
  end
end
