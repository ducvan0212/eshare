class CommentsController < ApplicationController
  before_filter :signed_in_user

  def create
    @exam_paper = ExamPaper.find(params[:comment][:exam_paper_id])
    current_user.comment!(@exam_paper, params[:comment][:content])
    respond_to do |format|
      format.js
    end 
  end

  def destroy
    @exam_paper = Comment.find(params[:id]).exam_paper
    current_user.rm_comment!(@exam_paper, params[:id])
    respond_to do |format|
      format.js
    end
  end
end
