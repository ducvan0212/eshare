class ExamPaper < ActiveRecord::Base
  attr_accessible :exam_date, :lecturer_id, :course_id

  belongs_to :user
  belongs_to :lecturer
  belongs_to :course

  validates :exam_date, presence: true
  validates :user_id, presence: true
  validates :lecturer_id, presence: true
  validates :course_id, presence: true
end
