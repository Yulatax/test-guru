class TestsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test, only: %i[start]

  def index
    @tests = Test.all
  end

  def start
    if @test.questions.empty?
      redirect_to tests_path, alert: t('.empty')
      return
    end

    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

end
