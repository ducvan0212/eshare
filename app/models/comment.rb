class Comment < ActiveRecord::Base
  attr_accessible :content, :exam_paper_id, :user_id
  belongs_to :user
  belongs_to :exam_paper

  validates :user_id, presence: true
  validates :exam_paper, presence: true
end
