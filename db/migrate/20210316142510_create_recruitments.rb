class CreateRecruitments < ActiveRecord::Migration[6.0]
  def change
    create_table :recruitments do |t|
      t.datetime :interview_time
      t.string :calling

      t.timestamps
      t.belongs_to :curriculum_vitae, foreign_key: true
      t.belongs_to :job, foreign_key: true
    end
  end
end
