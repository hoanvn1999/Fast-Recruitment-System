class CreateEducations < ActiveRecord::Migration[6.0]
  def change
    create_table :educations do |t|
      t.string :university_name
      t.datetime :start_date
      t.datetime :end_date
      t.float :gpa

      t.timestamps
      t.belongs_to :curriculum_vitae, foreign_key: true
    end
  end
end
