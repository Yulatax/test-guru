class User < ApplicationRecord

  has_many :passing_tests
  has_many :tests, through: :passing_tests
  has_many :authorized_tests, class_name: 'Test', foreign_key: 'author_id'

  def tests_by_level(level)
    Test.where("level = ?", level).joins("JOIN passing_tests ON tests.id = passing_tests.test_id").where("user_id = ?", self.id)
  end

end
