class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :author, only: [ :edit, :update, :destroy]

  def index
    @questions = Question.all
  end
  

  def show
  end


  def new
    @question = Question.new
  end


  def edit
  end


  def create
      @question = Question.new(question_params)
      @question.user = current_user
    if
      @question.save
      flash[:notice] = 'Your question created!'
      redirect_to @question
    else
      render :new
    end
  end


  def update
    if 
      @question.update(question_params)
      flash[:notice] = "Your question update!"
      redirect_to @question
    else
      render :edit
    end
  end


  def destroy
    @question.destroy
    flash[:notice] = "Your question deleted!"
    redirect_to questions_path

  end


  private

  def load_question
    @question = Question.find(params[:id])
  end


  def question_params
    params.require(:question).permit(:title, :body)
  end

  def author
    redirect_to root_url, notice: "You are not an author" unless @question.user == current_user
  end

end