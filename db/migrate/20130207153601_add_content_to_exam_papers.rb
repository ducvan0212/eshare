class AddContentToExamPapers < ActiveRecord::Migration
  def change
    add_column :exam_papers, :content, :text
  end
end
