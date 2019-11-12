class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound,
              with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show

  end

  def new

  end

  def create
    @question = @test.questions.create(question_params)
    if @question.save
      redirect_to @question
    else
      render plain: @question.inspect
    end
  end

  def destroy
    @question.destroy
    render plane: 'Question was successfully removed'
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: "Question was not found"
  end
end
