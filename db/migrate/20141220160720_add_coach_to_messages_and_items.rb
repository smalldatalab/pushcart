class AddCoachToMessagesAndItems < ActiveRecord::Migration
  def change
    add_reference     :messages, :coach,            index: true
    remove_reference  :messages, :oauth_application
    remove_column     :items,    :swap_id,          :integer
    remove_column     :items,    :swap_feedback,    :string

    create_table(:swap_suggestions) do |t|
      t.references :coach, index: true
      t.references :user, index: true
      t.references :swap, index: true
      t.references :item, index: true
      t.references :message, index: true

      t.datetime   :message_sent_at
      t.datetime   :swap_rated_at

      t.integer    :user_rating
      t.string     :feedback

      t.timestamps
    end
  end
end
