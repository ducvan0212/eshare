class Report < ActiveRecord::Base
  attr_accessible :exam_paper_id, :user_id
  belongs_to :user
  belongs_to :exam_paper

  validates :exam_paper_id, presence: true
  validates :user_id, presence: true
end
