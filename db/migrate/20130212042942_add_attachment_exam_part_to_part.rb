class AddAttachmentExamPartToPart < ActiveRecord::Migration
  def self.up
    change_table :parts do |t|
      t.attachment :exam_part
    end
  end

  def self.down
    drop_attached_file :parts, :exam_part
  end
end
