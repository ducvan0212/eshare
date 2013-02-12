class ExamPapersController < ApplicationController
  def new
    @exam_paper = ExamPaper.new
    3.times do
      parts = @exam_paper.parts.build
    end
  end

  def create
    @exam_paper = current_user.exam_papers.build(params[:exam_paper])
    if @exam_paper.save 
      redirect_to @exam_paper
    else
      render 'new'
    end
  end

  def edit
    @exam_paper = ExamPaper.find(params[:id])
  end

  def update
    @exam_paper = ExamPaper.find(params[:id])
    if @exam_paper.update_attributes(params[:exam_paper]) 
      redirect_to @exam_paper
    else
      render 'new'
    end
  end

  def show
    @exam_paper = ExamPaper.find(params[:id])
  end

  def destroy
  end
end
