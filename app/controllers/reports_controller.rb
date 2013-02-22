class ReportsController < ApplicationController
  def create
    @exam_paper = ExamPaper.find(params[:report][:exam_paper_id])
    current_user.report!(@exam_paper)
    respond_to do |format|
      format.js
    end 
  end

  def destroy
    @exam_paper = Report.find(params[:id]).exam_paper
    current_user.rm_report!(@exam_paper)
    respond_to do |format|
      format.js
    end
  end
end
