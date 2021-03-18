class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.text :title
      t.text :content
      t.integer :number_of_staffs
      t.integer :type_of_work
      t.integer :position
      t.float :min_salary
      t.float :max_salary
      t.float :candidate_experience
      t.datetime :due_date
      t.integer :status

      t.timestamps
      t.belongs_to :user, foreign_key: true
      t.belongs_to :field, foreign_key: true
    end
    add_index :jobs, :created_at
  end
end
