class CreateReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :references do |t|
      t.string :name
      t.string :phone_number
      t.string :email

      t.timestamps
      t.belongs_to :curriculum_vitae, foreign_key: true
    end
  end
end
