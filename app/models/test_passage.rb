class TestPassage < ApplicationRecord
  SUCCESS_SCORE = 85

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

  def calculate_score
    (self.correct_questions.to_f / test.questions.count * 100).round(2)
  end

  def success?
    # calculate_score >= SUCCESS_SCORE ? 'text-success' : 'text-danger'
    calculate_score >= SUCCESS_SCORE
  end

  def set_class
    success? ? 'text-success' : 'text-danger'
  end

  def current_question_number
    self.test.questions.order(:id).index(self.current_question) + 1
  end

  def rewarding
    rules = Badge.distinct.pluck(:rule)
    rewards = []
    rules.each do |rule|
      case rule
      when 'First try'
        rewards << first_try_reward
      when 'CSS Category'
        rewards << css_category_reward
      when 'Third Level'
        rewards << third_level_reward
      end
    end
    rewards
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

  def first_try_reward
    badge = Badge.find_by_rule('First try')

    unless success? && self.user.test_passage_count(self.test.id) == 1
      return
    end

    user.rewardings.create(badge: badge)
  end

  def css_category_reward
    return unless self.test.category.title == 'CSS'

    badge = Badge.find_by_rule('CSS Category')
    css_tests = Test.tests_by_category('CSS')
    results = user_test_passage_scores_array(css_tests)
    return if results.include?(false)

    user.rewardings.create(badge: badge)
  end

  def third_level_reward
    return unless self.test.level == 3

    badge = Badge.find_by_rule('Third Level')
    third_level_tests = Test.by_level(3)
    results = user_test_passage_scores_array(third_level_tests)
    return if results.include?(false)

    user.rewardings.create(badge: badge)
  end

  def user_test_passage_scores_array(tests)
    results = []
    tests.each do |test|
      test_pass = self.user.test_passage(test)
      if test_pass.present?
        results << test_pass.success?
      end
    end
    results
  end
end
