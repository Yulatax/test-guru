class Badge < ApplicationRecord

  has_many :rewardings, dependent: :destroy
  has_many :users, through: :rewardings, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  class << self
    def find_by_rule(rule)
      Badge.find_by!(rule: rule)
    end
  end

  def count(user)
    user.rewardings.where("badge_id = ?", self.id).count
  end
end