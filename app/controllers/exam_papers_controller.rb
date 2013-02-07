class ExamPapersController < ApplicationController
  def new
    @exam_paper = ExamPaper.new
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
  end

  def update
  end

  def show
    @exam_paper = ExamPaper.find(params[:id])  
  end

  def destroy
  end
end
