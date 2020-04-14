# frozen_string_literal: true

module SolutionProposalsHelper
  def self.solutions_for_proposal(proposal)
    Solution.joins(:decidim_proposals_proposals).where("decidim_proposals_proposals.id = ?", proposal.id)
  end
end
