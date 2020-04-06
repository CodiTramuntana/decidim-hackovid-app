# frozen_string_literal: true

class SolutionsSearch < ::Decidim::ResourceSearch
  # Public: Initializes the service.
  # page        - The page number to paginate the results.
  # per_page    - The number of proposals to return per page.
  def initialize(options = {})
    @component = options[:component]
    @current_user = options[:current_user]

    super(Solution.all, options)
  end

  def base_query
    @scope
  end

  # Handle the search_text filter
  def search_search_text
    query
      .where("title ILIKE ?", "%#{search_text}%")
  end

  def search_category_id
    super
  end

  def search_scope_id
    super
  end

  def results
    Solution.where(id: super.pluck(:id))
  end
end
