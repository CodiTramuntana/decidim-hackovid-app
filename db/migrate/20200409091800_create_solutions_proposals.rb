class CreateSolutionsProposals < ActiveRecord::Migration[5.2]
  def change

    create_join_table :solutions, :decidim_proposals_proposals do |t|
      t.index [:solution_id, :decidim_proposals_proposal_id], name: 'index_solution_proposal'
    end

  end
end
