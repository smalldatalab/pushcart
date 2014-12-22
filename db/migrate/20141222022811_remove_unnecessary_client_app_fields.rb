class RemoveUnnecessaryClientAppFields < ActiveRecord::Migration
  def change
    remove_reference :messages, :oauth_applications
  end
end
