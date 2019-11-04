class User < ApplicationRecord

  has_many :passing_tests
  has_many :tests, through: :passing_tests
  has_many :authorized_tests, class_name: 'Test', foreign_key: 'author_id'

  validates :email, presence: true

  def tests_by_level(level)
    self.tests.by_level(level)
  end

end
