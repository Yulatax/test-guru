class Category < ApplicationRecord
  has_many :tests

  validates :title, presence: true, uniqueness: true

  scope :by_name, -> (category){ find_by('lower(title) = ?', category.downcase) }
  default_scope { order('lower(title) ASC') }
end
