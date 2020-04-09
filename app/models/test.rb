class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages, dependent: :destroy

  validates :title, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level, message: "should be unique pair of title and level for test" }

  scope :simple, -> { where(level: [0,1]) }
  scope :middle, -> { where(level: 2..4) }
  scope :difficult, -> { where(level: 5..Float::INFINITY) }

  scope :by_level, -> (level) { where(level: level) }
  scope :ordered, -> { order('lower(title) DESC') }

  class << self
    def tests_by_category(category)
      # Category.by_name(category).tests.ordered.pluck(:title)
      Test.joins(:category).where(categories: {title: category}).order(title: :desc).pluck(:title)
    end
  end
end
