class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :exam_paper_id

      t.timestamps
    end
    add_index :bookmarks, :user_id
    add_index :bookmarks, :exam_paper_id
    add_index :bookmarks, [:user_id, :exam_paper_id], unique: true
  end
end
