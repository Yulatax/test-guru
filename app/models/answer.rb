class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :answers_limit

  scope :correct, -> { where(correct: true ) }

  private

  def answers_limit
    errors.add(:limit, 'no more then 4 answers per question') if self.question.answers.count >= 4
  end
end
