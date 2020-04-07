# frozen_string_literal: true

class SolutionsController < Decidim::ApplicationController
  include ::Decidim::ApplicationHelper
  include ::Decidim::FilterResource
  include ::Decidim::Paginable
  include ::Decidim::CheckBoxesTreeHelper

  helper ::Decidim::FiltersHelper
  helper_method :current_participatory_space
  helper_method :current_component
  helper_method :filter_categories_values
  helper_method :check_boxes_tree_options

  def index
    @solutions = search
                     .results
                     .published
                     .includes(:sd_goal)
                     # .includes(:category)
    @solutions = paginate(@solutions)
  end

  private

  def search_klass
    SolutionsSearch
  end

  def default_filter_params
    {
      component: current_component,
      search_text: "",
      category_id: default_filter_category_params,
      scope_id: default_filter_scope_params,
    }
  end

  def default_filter_category_params
    return "all"
    # return "all" unless current_component.participatory_space.categories.any?

    # ["all"] + current_component.participatory_space.categories.map { |category| category.id.to_s }
  end

  def default_filter_scope_params
    return "all"
    # return "all" unless current_component.participatory_space.scopes.any?

    # if current_component.participatory_space.scope
    #   ["all", current_component.participatory_space.scope.id] + current_component.participatory_space.scope.children.map { |scope| scope.id.to_s }
    # else
    #   %w(all global) + current_component.participatory_space.scopes.map { |scope| scope.id.to_s }
    # end
  end

  def current_participatory_space
    @current_participatory_space||= ::Decidim::ParticipatoryProcess.find_by_slug("solucions-hackovid") || ::Decidim::ParticipatoryProcess.last
  end

  def current_component
    @current_component||= current_participatory_space.components.where.not(published_at: nil).last
  end
end
