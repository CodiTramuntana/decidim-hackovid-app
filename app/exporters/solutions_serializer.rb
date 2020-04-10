# frozen_string_literal: true

# This class serializes a Proposal so can be exported to CSV, JSON or other
# formats.
class SolutionsSerializer < Decidim::Exporters::Serializer
  # include Decidim::ApplicationHelper
  # include Decidim::ResourceHelper
  include Decidim::TranslationsHelper

  # Public: Initializes the serializer with a solution.
  def initialize(solution)
    @solution = solution
  end

  # Public: Exports a hash with the serialized data for this solution.
  def serialize
    h= {
      id: solution.id,
      title: solution.title,
      description: solution.description,
      explanation: solution.explanation,
      youtube_link: "https://www.youtube.com/watch?v=#{solution.youtube_link}",
      github_link: solution.github_link,
      web_link: solution.web_url,
      android_market_link: solution.android_mkt_url,
      ios_market_link: solution.ios_mkt_url,
      firebase_link: solution.source_link,
      market_probe: solution.file_file_name,
      ods: solution.sd_goal_id,
      ods_name: solution&.sd_goal.name,
      team_name: solution.team_name,
      decidim_user_id: solution.decidim_user_id,
      decidim_user_nickname: solution&.user.nickname,
      created_at: solution.created_at,
      updated_at: solution.updated_at,
    }
    h[:categories]= solution.decidim_proposals_proposals.map do |p|
      translated_attribute(p.category.try(:name))
    end.uniq
    h[:necessitats]= solution.decidim_proposals_proposals.map do |p|
      Decidim::Proposals::ProposalPresenter.new(p).title
    end
    h
  end

  private

  attr_reader :solution

end
