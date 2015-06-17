class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :load_question_id, only: [:create]


  def new
    @answer = Answer.new
  end


  def create
      @answer = @question.answers.new(answer_params)
    if @answer.user = current_user
      @answer.save
      flash[:notice] = 'Your answer created!'
      redirect_to @answer.question
    else 
      render :new
    end
  end


  def destroy
      @answer = Answer.find(params[:id])
    if @answer.user == current_user
      @answer.destroy
      flash[:notice] = 'Your answer deleted!'
      redirect_to @answer.question
    else
      redirect_to root_url, notice: "You are not an author" 
    end
  end


  private

  def load_question_id
    @question = Question.find(params[:question_id])
  end


  def answer_params
    params.require(:answer).permit(:body)
  end


end