class CreateCurriculumVitaes < ActiveRecord::Migration[6.0]
  def change
    create_table :curriculum_vitaes do |t|
      t.text :about_me
      t.integer :mark

      t.timestamps
      t.belongs_to :user, foreign_key: true
      t.belongs_to :field, foreign_key: true
    end
  end
end
