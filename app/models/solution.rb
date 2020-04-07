class Solution < ApplicationRecord
  # include ::Decidim::HasCategory

  # has_one :categorization, as: :categorizable, class_name: 'Decidim::Categorization'
  # has_one :category, through: :categorization, class_name: 'Decidim::Category'
  belongs_to :sd_goal, class_name: 'SDGoal'
  belongs_to :user, foreign_key: 'decidim_user_id', class_name: '::Decidim::User'

  scope :published, -> { where.not(published_at: nil) }
end
