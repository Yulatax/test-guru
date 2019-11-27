class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :before_validation_set_next_question, on: :update

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    save!
  end

  def completed?
    current_question.nil?
  end

  def result
    {
        score: calculate_score,
        class: result_type(@score)
    }
  end

  def current_question_number
    self.test.questions.order(:id).index(self.current_question) + 1
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    # correct_answers_count = correct_answers.count
    # (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
    #     correct_answers_count == answer_ids.count
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def before_validation_set_next_question
    self.current_question = next_question
  end

  def calculate_score
    @score = (self.correct_questions.to_f / test.questions.count * 100).round(2)
  end

  def result_type(result)
    result >= 85 ? 'success' : 'failure'
  end

end
