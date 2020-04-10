# frozen_string_literal: true

class SolutionsController < Decidim::ApplicationController
  include ::Decidim::ApplicationHelper
  include ::Decidim::FilterResource
  include ::Decidim::Paginable
  include ::Decidim::CheckBoxesTreeHelper

  helper ::Decidim::FiltersHelper
  helper ::Decidim::ActionAuthorizationHelper
  helper_method :current_participatory_space
  helper_method :current_component
  helper_method :filter_categories_values
  helper_method :check_boxes_tree_options

  def index
    @solutions = search
                     .results
                     .includes(:sd_goal)
    @solutions = paginate(@solutions)
  end

  def new
    @solution = Solution.new
  end

  def create
    @solution = Solution.new( solution_params )

    @solution.user= current_user
    if @solution.save
      flash[:success] = I18n.t("solutions.success")
      redirect_to solutions_path
    else
      render :new
    end
  end

  def export
    return head :forbidden unless current_user.admin?

    rs= Decidim::Exporters.find_exporter('CSV').new(Solution.all, SolutionsSerializer).export
    send_data(rs.read, filename: rs.filename('solucions'))
  end

  private

  def search_klass
    SolutionsSearch
  end

  def default_filter_params
    {
      component: current_component,
      search_text: "",
      ods_ids: {},
      category_id: default_filter_category_params,
    }
  end

  def default_filter_category_params
    return "all" unless current_component.participatory_space.categories.any?

    ["all"] + current_component.participatory_space.categories.map { |category| category.id.to_s }
  end

  def current_participatory_space
    @current_participatory_space||= ::Decidim::ParticipatoryProcess.find_by_slug("solucions-hackovid") || ::Decidim::ParticipatoryProcess.first
  end

  def current_component
    @current_component||= current_participatory_space.components.where.not(published_at: nil).where(manifest_name: 'proposals').first
  end

  def solution_params
    params.require(:solution).permit(:title, :description, :explanation, :youtube_link, :github_link, :source_link, :web_url, :android_mkt_url, :ios_mkt_url, :sd_goal_id, :team_name, :user_id, :file, decidim_proposals_proposal_ids:[])
  end
end
