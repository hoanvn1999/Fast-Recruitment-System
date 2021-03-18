class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.string :skill_name

      t.timestamps
      t.belongs_to :curriculum_vitae, foreign_key: true
    end
  end
end
