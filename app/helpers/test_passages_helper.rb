module TestPassagesHelper

  def show_message(type)
    type == 'success'? successful_message : failure_message
  end

  private

  def successful_message
    "Congratulations! You've passed the test!"
  end

  def failure_message
    "Sorry! Your result is not good enough. Try again!"
  end

end
