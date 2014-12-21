class DeviseCreateCoaches < ActiveRecord::Migration
  def change
    create_table(:coaches) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at


      t.timestamps
    end

    add_index :coaches, :email,                unique: true
    add_index :coaches, :reset_password_token, unique: true
    add_index :coaches, :confirmation_token,   unique: true
    add_index :coaches, :unlock_token,         unique: true

    create_table(:memberships) do |t|
      t.references :coach, index: true
      t.references :user, index: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        AdminUser.all.each do |a|
          Coach.create(email: a.email, password: "00000000")
        end
      end
    end
  end
end
