class Comment < ActiveRecord::Base
  attr_accessible :content, :exam_paper_id, :user_id
end
