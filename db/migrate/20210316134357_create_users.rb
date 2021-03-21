class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone_number
      t.string :password_digest
      t.string :full_name
      t.datetime :date_of_birth
      t.text :address
      t.integer :role
      t.integer :institution_id, default: 1
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :actived_at
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.string :remember_digest

      t.timestamps
    end
    add_index :users, :institution_id
    add_index :users, :actived_at
  end
end
