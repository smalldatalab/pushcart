class RemoveUnnecessaryClientAppFields < ActiveRecord::Migration
  def change
    remove_column :oauth_application, :endpoint_email, :string
  end
end
