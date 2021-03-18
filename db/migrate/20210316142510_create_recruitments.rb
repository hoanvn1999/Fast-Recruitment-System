class CreateRecruitments < ActiveRecord::Migration[6.0]
  def change
    create_table :recruitments do |t|
      t.integer :job_id

      t.timestamps
      t.belongs_to :curriculum_vitae, foreign_key: true
    end
  end
end
