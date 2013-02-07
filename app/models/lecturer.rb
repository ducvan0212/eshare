class Lecturer < ActiveRecord::Base
  attr_accessible :name

  has_many :exam_papers
  has_many :courses, through: :exam_papers
end
