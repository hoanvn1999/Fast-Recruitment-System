class CreateCurriculumVitaes < ActiveRecord::Migration[6.0]
  def change
    create_table :curriculum_vitaes do |t|
      t.string :about_me
      t.float :education_time
      t.float :experience_time
      t.float :extra_experience_time

      t.timestamps
      t.belongs_to :user, foreign_key: true
      t.belongs_to :field, foreign_key: true
    end
  end
end
