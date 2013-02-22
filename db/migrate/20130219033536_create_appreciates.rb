class CreateAppreciates < ActiveRecord::Migration
  def change
    create_table :appreciates do |t|
      t.integer :user_id
      t.integer :exam_paper_id

      t.timestamps
    end
    add_index :appreciates, :user_id
    add_index :appreciates, :exam_paper_id
    add_index :appreciates, [:user_id, :exam_paper_id], unique: true
  end
end
