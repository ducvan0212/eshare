class CreateExamPapers < ActiveRecord::Migration
  def change
    create_table :exam_papers do |t|
      t.date :exam_date
      t.integer :user_id
      t.integer :lecturer_id
      t.integer :course_id
      
      t.timestamps
    end
    add_index :exam_papers, [:user_id, :created_at]
  end
end
