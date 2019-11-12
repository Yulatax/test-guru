class TestsController < ApplicationController

  def index
    # render json: {tests: Test.all}
    render file: 'public/about.html', layout: false
  end

  def show

  end
end
