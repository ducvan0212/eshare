class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :exam_paper_id
      t.timestamps
    end
    add_index :parts, :exam_paper_id
  end
end
