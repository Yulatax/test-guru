class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]
  before_action :set_current_question_number, only: :show
  before_action :set_gist, only: :gist

  def show

  end

  def result
    @score = @test_passage.calculate_score
    @class = @test_passage.set_class
    @rewards = @test_passage.rewarding

    p @rewards
    unless @rewards.any?
      return
    end

    show_notice(@rewards)
  end

  def update
    if params[:answer_ids].nil?
      redirect_to @test_passage, alert: t('.empty_answer')
      return
    end

    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      redirect_to test_passage_path(@test_passage)
    end
  end

  def gist
    if @gist.present?
      redirect_to @test_passage, notice: t('.present', link: @gist.url)
      return
    end

    gist_service = GistQuestionService.new(@test_passage.current_question)
    res = gist_service.call

    flash_options = if gist_service.success?
                      create_gist(res[:html_url])
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

  def set_gist
    @gist = Gist.find_by(user_id: current_user.id, question_id: @test_passage.current_question.id)
  end

  def show_notice(rewards)
    str = ''
    rewards.each do |reward|
      unless reward.nil?
        str += " '#{reward.badge.title}'"
      end
    end
    # flash.now[:notice] = "You got new #{str} badge!"
    flash.now[:notice] = t('.message', badges: str)
  end
end
