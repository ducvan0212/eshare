class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :avatar
  
  has_secure_password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :smallest => "75x75" }, 
                             :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                             :url => "/system/:attachment/:id/:style/:filename"
  has_many :exam_papers, dependent: :destroy
  has_many :appreciates, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, 
                    uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates_attachment :avatar, :content_type => { :content_type => ['image/jpeg', 'image/png'] },
                                :size => { :in => 0..1.megabytes }

  def appreciate!(exam_paper)
    appreciates.create!(exam_paper_id: exam_paper.id)
  end

  def appreciated?(exam_paper)
    appreciates.find_by_exam_paper_id(exam_paper.id)
  end

  def rm_appreciate!(exam_paper)
    appreciates.find_by_exam_paper_id(exam_paper.id).destroy
  end

  def report!(exam_paper)
    reports.create!(exam_paper_id: exam_paper.id)
  end

  def reported?(exam_paper)
    reports.find_by_exam_paper_id(exam_paper.id)
  end

  def rm_report!(exam_paper)
    reports.find_by_exam_paper_id(exam_paper.id).destroy
  end

  def comment!(exam_paper, content)
    comments.create!(exam_paper_id: exam_paper.id, content: content)
  end

  def rm_comment!(exam_paper, comment_id)
    comments.where("exam_paper_id = ?", exam_paper.id).select{|c| c.id == comment_id.to_i}.first.destroy
  end

  def bookmark!(exam_paper)
    bookmarks.create!(exam_paper_id: exam_paper.id)
  end

  def bookmarked?(exam_paper)
    bookmarks.find_by_exam_paper_id(exam_paper.id)
  end

  def rm_bookmark!(exam_paper)
    bookmarks.find_by_exam_paper_id(exam_paper.id).destroy
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
