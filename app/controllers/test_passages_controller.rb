class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]
  before_action :set_current_question_number, only: :show

  def show

  end

  def result
    @score = @test_passage.calculate_score
    @class = @test_passage.success?
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      redirect_to test_passage_path(@test_passage)
    end
  end

  def gist
    gist_service = GistQuestionService.new(@test_passage.current_question)
    res = gist_service.call

    flash_options = if gist_service.success?
                      create_gist(res[:url])
                      { notice: t('.success', link: res[:html_url]) }
                    else
                      { alert: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def set_current_question_number
    @number = @test_passage.current_question_number
  end

  def create_gist(url)
    current_user.gists.create(url: url, question: @test_passage.current_question)
  end
end
