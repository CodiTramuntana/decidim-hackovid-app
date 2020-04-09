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
      youtube_link: solution.youtube_link,
      github_link: solution.github_link,
      web_url: solution.web_url,
      android_mkt_url: solution.android_mkt_url,
      ios_mkt_url: solution.ios_mkt_url,
      sd_goal_id: solution.sd_goal_id,
      team_name: solution.team_name,
      decidim_user_id: solution.decidim_user_id,
      created_at: solution.created_at,
      updated_at: solution.updated_at,
    }
    h[:categories]= solution.decidim_proposals_proposals.map do |p|
      {
        id: p.category.try(:id),
        name: p.category.try(:name) || empty_translatable
      }
    end
    h[:proposals]= solution.decidim_proposals_proposals.map do |p|
      presenter= Decidim::Proposals::ProposalPresenter.new(p)
      {
        id: p.id,
        title: presenter.title,
        category: {
          id: p.category.try(:id),
          name: p.category.try(:name) || empty_translatable
        }
      }
    end
    h
  end

  private

  attr_reader :solution

end
