require 'digest/sha1'

class User < ApplicationRecord

  # include Auth

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :authorized_tests, class_name: 'Test', foreign_key: 'author_id'

  validates :email, uniqueness: true,
                    format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-za-z]{2,4}\z/}, on: :create

  has_secure_password

  def tests_by_level(level)
    self.tests.by_level(level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

end
