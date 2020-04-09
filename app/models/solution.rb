class Solution < ApplicationRecord
  # include ::Decidim::HasCategory

  # has_one :categorization, as: :categorizable, class_name: 'Decidim::Categorization'
  # has_one :category, through: :categorization, class_name: 'Decidim::Category'
  belongs_to :sd_goal, class_name: 'SDGoal'
  belongs_to :user, foreign_key: 'decidim_user_id', class_name: '::Decidim::User'
  has_and_belongs_to_many :decidim_proposals_proposals, association_foreign_key: 'decidim_proposals_proposal_id', class_name: '::Decidim::Proposals::Proposal'

  validates :title, :description, :youtube_link, :github_link, :team_name, presence: true
  validates :decidim_proposals_proposal_ids, length: { minimum: 1, maximum: 3, message: I18n.t('solutions.errors.mandatory_proposals') }

  # validate :external_apps_present, on: :create

  private

  #
  # def external_apps_present
  #  if web_url.blank? and android_mkt_url.blank? and ios_mkt_url.blank?
  #    errors[:base] << I18n.t('solutions.errors.external_apps_present')
  #  end
  # end
end
