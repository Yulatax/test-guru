module QuestionsHelper

  def form_header(question)
    if question.new_record?
      t('.new_question', title: question.test.title)
    else
      t('.edit_question', title: question.test.title)
    end
  end
end
