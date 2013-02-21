class CreateAppreciates < ActiveRecord::Migration
  def change
    create_table :appreciates do |t|
      t.integer :user_id
      t.integer :exam_paper_id

      t.timestamps
    end
  end
end
