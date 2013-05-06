class BookmarksController < ApplicationController
  before_filter :signed_in_user

  def create
    @exam_paper = ExamPaper.find(params[:bookmark][:exam_paper_id])
    current_user.bookmark!(@exam_paper)
    respond_to do |format|
      format.js
    end 
  end

  def destroy
    @exam_paper = Bookmark.find(params[:id]).exam_paper
    current_user.rm_bookmark!(@exam_paper)
    @user = @exam_paper.user
    @bookmarks = @user.bookmarks
    respond_to do |format|
      format.js
    end
  end
end
