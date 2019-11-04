class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions
  has_many :passing_tests
  has_many :users, through: :passing_tests

  class << self
    def tests_by_category(category)
      Test.joins("JOIN categories ON tests.category_id = categories.id")
          .where("categories.title = ?", category).order(title: :desc).pluck(:title)
    end
  end
end
