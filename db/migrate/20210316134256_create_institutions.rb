class CreateInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :institutions do |t|
      t.string :institution_name
      t.text :address
      t.string :logo
      t.text :description

      t.timestamps
    end
    add_index :institutions, :institution_name
  end
end
