class ExamPaper < ActiveRecord::Base
  attr_accessible :exam_date, :lecturer_id, :course_id, :content, :parts_attributes

  belongs_to :user
  belongs_to :lecturer
  belongs_to :course
  has_many :parts, dependent: :destroy
  accepts_nested_attributes_for :parts, :reject_if => lambda { |a| a[:exam_part].blank? }, :allow_destroy => true

  validates :user_id, presence: true
  validates :lecturer_id, presence: true
  validates :course_id, presence: true
end
