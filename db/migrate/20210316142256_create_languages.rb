class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :language_name

      t.timestamps
      t.belongs_to :curriculum_vitae, foreign_key: true
    end
  end
end
