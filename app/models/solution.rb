class Solution < ApplicationRecord
  # include ::Decidim::HasCategory

  has_one :categorization, as: :categorizable, class_name: 'Decidim::Categorization'
  has_one :category, through: :categorization
  belongs_to :ods

  scope :published, -> { where.not(published_at: nil) }
end
