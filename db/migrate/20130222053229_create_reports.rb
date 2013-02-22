class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :exam_paper_id

      t.timestamps
    end
    add_index :reports, :user_id
    add_index :reports, :exam_paper_id
    add_index :reports, [:user_id, :exam_paper_id], unique: true
  end
end
