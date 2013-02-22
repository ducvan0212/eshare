class ExamPaper < ActiveRecord::Base
  attr_accessible :exam_date, :lecturer_id, :course_id, :content, :parts_attributes

  belongs_to :user
  belongs_to :lecturer
  belongs_to :course
  has_many :parts, dependent: :destroy
  has_many :appreciates, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :parts, :reject_if => lambda { |a| a[:exam_part].blank? }, :allow_destroy => true

  validates :exam_date, presence: true
  validates :content, presence: true
  validates :lecturer_id, presence: true
  validates :course_id, presence: true

  def self.search(lecturer, course)
    if(lecturer != -1 && course != -1)
      where("lecturer_id = ? AND course_id = ?", lecturer, course)
    elsif lecturer != -1 
      where("lecturer_id = ?", lecturer)
    elsif course != -1
      where("course_id = ?", course)
    else
      ExamPaper.all
    end    
  end
end
