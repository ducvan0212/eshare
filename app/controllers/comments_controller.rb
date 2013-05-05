class CommentsController < ApplicationController
  before_filter :signed_in_user

  def create
    @exam_paper = ExamPaper.find(params[:comment][:exam_paper_id])
    current_user.comment!(@exam_paper, params[:comment][:content])
    comments = @exam_paper.comments.paginate(page: params[:page], per_page: 5)
    last_page = comments.total_pages
    @comments = @exam_paper.comments.paginate(page: last_page, per_page: 5)
    respond_to do |format|
      format.js
    end 
  end

  def destroy
    comment = Comment.find(params[:id])
    @exam_paper = comment.exam_paper
    current_page = @exam_paper.comments.index(comment) / 5 + 1
    current_user.rm_comment!(@exam_paper, params[:id])
    @comments = @exam_paper.comments.paginate(page: current_page, per_page: 5)
    respond_to do |format|
      format.js
    end
  end
end
