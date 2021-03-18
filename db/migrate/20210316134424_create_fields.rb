class CreateFields < ActiveRecord::Migration[6.0]
  def change
    create_table :fields do |t|
      t.string :field_name
      t.text :description

      t.timestamps
    end
    add_index :fields, :field_name
  end
end
