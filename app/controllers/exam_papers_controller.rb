class ExamPapersController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy, :index]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  before_filter :admin_user, only: [:index, :destroy]
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
    binding.pry
    ExamPaper.find(params[:id]).destroy
    redirect_to exam_papers_path
  end

  def index
    @exam_papers = ExamPaper.all.paginate(page: params[:page], per_page: 10)  
  end

  def search
    if !params[:lecturer].nil? && !params[:course].nil?
      lecturer = params[:lecturer].empty? ? -1 : params[:lecturer].to_i
      course = params[:course].empty? ? -1 : params[:course].to_i
      @results = []
      if lecturer <= Lecturer.last.id && course <= Course.last.id
        @results = ExamPaper.search(lecturer, course).paginate(:page => params[:page], :per_page => 20)
      end
    end
  end

  private
    def correct_user
      if current_user.admin?
        @exam_paper = ExamPaper.find(params[:id])
      else
        @exam_paper = current_user.exam_papers.find_by_id(params[:id])
      end
      redirect_to root_path if @exam_paper.nil?
    end

    def admin_user
      redirect_to root_path if !current_user.admin?
    end
end
