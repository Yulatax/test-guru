module TestPassagesHelper

  def show_message(type)
    type == 'success'? successful_message : failure_message
  end

  private

  def successful_message
    t('.success')
  end

  def failure_message
    t('.failure')
  end

end
