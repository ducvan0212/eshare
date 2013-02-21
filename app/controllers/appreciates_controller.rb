class AppreciatesController < ApplicationController
  def create
    @exam_paper = ExamPaper.find(params[:appreciate][:exam_paper_id])
    current_user.appreciate!(@exam_paper)
    respond_to do |format|
      format.js
    end 
  end

  def destroy
    @exam_paper = Appreciate.find(params[:id]).exam_paper
    current_user.rm_appreciate!(@exam_paper)
    respond_to do |format|
      format.js
    end
  end
end
