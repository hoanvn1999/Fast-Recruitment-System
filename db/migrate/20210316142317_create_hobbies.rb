class CreateHobbies < ActiveRecord::Migration[6.0]
  def change
    create_table :hobbies do |t|
      t.string :hobby_name

      t.timestamps
      t.belongs_to :curriculum_vitae, foreign_key: true
    end
  end
end
