# frozen_string_literal: true

class SolutionsSearch < ::Searchlight::Search
  # Public: Initializes the service.
  # page        - The page number to paginate the results.
  # per_page    - The number of proposals to return per page.
  def initialize(options = {})
    @component = options[:component]
    @current_user = options[:current_user]

    super(options)
  end

  def base_query
    Solution.all
  end

  # Handle the search_text filter
  def search_search_text
    return query unless search_text.present?

    query
      .where("solutions.title ILIKE ?", "%#{search_text}%")
  end

  def search_category_id
    return query if category_ids.include?("all")

    # proposal_ids= query.all.collect do |solution|
    #   solution.decidim_proposals_proposals.where(
    #     "id IN (SELECT categorizable_id FROM decidim_categorizations WHERE categorizable_type= ? AND decidim_category_id IN (?))",
    #     ::Decidim::Proposals::Proposal,
    #     all_category_ids).pluck(:id)
    # end.flatten
    # query.joins(:decidim_proposals_proposals).where("decidim_proposals_proposals.id IN (?)", proposal_ids)
    query
      .joins(decidim_proposals_proposals: :category)
      .where(
        "decidim_proposals_proposals.id IN (SELECT categorizable_id FROM decidim_categorizations WHERE categorizable_type= ? AND decidim_category_id IN (?))",
        ::Decidim::Proposals::Proposal,
        all_category_ids)
  end

  def search_ods_ids
    selected_sdgs= ods_ids.each_entry.map {|sdg_id, checked| checked == '1' ? sdg_id : nil }.compact
    return query if selected_sdgs.empty?

    query.where(sd_goal_id: selected_sdgs)
  end

  def results
    Solution.where(id: super.pluck(:id).uniq)
  end

  private

  # Private: Creates an array of category ids.
  # It contains categories' subcategories ids as well.
  def all_category_ids
    cat_ids = category_ids.without("without")

    @component
      .categories
      .where(id: cat_ids)
      .or(@component.categories.where(parent_id: cat_ids))
      .pluck(:id).tap { |ids| ids.prepend(nil) if category_ids.include?("without") }
  end

  # Private: Returns an array with checked category ids.
  def category_ids
    [category_id].flatten
  end

end
