class Solution < ApplicationRecord
  # include ::Decidim::HasCategory

  # has_one :categorization, as: :categorizable, class_name: 'Decidim::Categorization'
  # has_one :category, through: :categorization, class_name: 'Decidim::Category'
  belongs_to :sd_goal, class_name: 'SDGoal'
  belongs_to :user, foreign_key: 'decidim_user_id', class_name: '::Decidim::User'
  has_and_belongs_to_many :decidim_proposals_proposals, association_foreign_key: 'decidim_proposals_proposal_id', class_name: '::Decidim::Proposals::Proposal', dependent: :delete_all


  has_attached_file :file, styles: { medium: "300x>", thumb: "100x>" }
  validates_attachment :file, content_type: { content_type: [ 'image/png', 'image/jpeg', 'image/jpg', 'image/gif' ] }

  validates :title, :description, :explanation, :youtube_link, :github_link, :team_name,  presence: true
  validates :decidim_proposals_proposal_ids, length: { minimum: 1, maximum: 3, message: I18n.t('solutions.errors.mandatory_proposals') }

  validate :external_apps_present
  validates :youtube_link, format: { without: /\A(http[s]?\:\/\/)/,
    message: I18n.t('solutions.errors.youtube_link') }
  validates :firebase_url, presence: true, if: :firebase_shared?

  private

  def external_apps_present
   if web_url.blank? and android_mkt_url.blank? and ios_mkt_url.blank? and file_file_name.blank?
     errors[:base] << I18n.t('solutions.errors.external_apps_present')
   end
  end
end
