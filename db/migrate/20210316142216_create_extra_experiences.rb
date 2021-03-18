class CreateExtraExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :extra_experiences do |t|
      t.string :company_name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
      t.belongs_to :curriculum_vitae, foreign_key: true
    end
  end
end
