class Course < ActiveRecord::Base
  attr_accessible :name

  has_many :exam_papers
  has_many :lecturers, through: :exam_papers
end
