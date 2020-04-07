class Solution < ApplicationRecord
  # include ::Decidim::HasCategory

  # has_one :categorization, as: :categorizable, class_name: 'Decidim::Categorization'
  # has_one :category, through: :categorization, class_name: 'Decidim::Category'
  belongs_to :sd_goal, class_name: 'SDGoal'

  scope :published, -> { where.not(published_at: nil) }
end
