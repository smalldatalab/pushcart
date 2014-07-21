class InboundEmail < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user, index: true
      t.text       :raw_html
      t.text       :raw_text
      t.string     :to
      t.string     :from
      t.string     :subject
      t.boolean    :successfully_processed, default: false
      t.boolean    :scraped,                default: false

      t.timestamps
    end
  end
end
