class RemoveUnnecessaryClientAppFields < ActiveRecord::Migration
  def change
    remove_column :oauth_applications, :endpoint_email, :string
  end
end
