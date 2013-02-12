class Part < ActiveRecord::Base
  attr_accessible :exam_part
  has_attached_file :exam_part, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                                :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                                :url => "/system/:attachment/:id/:style/:filename"
                                
  belongs_to :exam_paper
  validates_attachment :exam_part, :content_type => { :content_type => ['image/jpeg', 'image/png'] },
                                :size => { :in => 0..1.megabytes }
end
