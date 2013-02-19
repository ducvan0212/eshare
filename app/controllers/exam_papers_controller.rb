class ExamPapersController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]
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

  def search
    lecturer = params[:lecturer].empty? ? -1 : params[:lecturer].to_i
    course = params[:course].empty? ? -1 : params[:course].to_i
    @results = ExamPaper.search(lecturer, course).paginate(:page => params[:page], :per_page => 10)
  end

  private
    def correct_user
      @exam_paper = current_user.exam_papers.find_by_id(params[:id])
      redirect_to root_path if @exam_paper.nil?
    end
end
