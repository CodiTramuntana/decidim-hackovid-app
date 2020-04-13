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
    return head :forbidden unless current_user.admin?
    @solution = Solution.new
  end

  def create
    return head :forbidden unless current_user.admin?
    @solution = Solution.new( solution_params )

    @solution.user= current_user
    if @solution.save
      flash[:success] = I18n.t("solutions.success")
      redirect_to solutions_path
    else
      render :new
    end
  end

  def edit
    return head :forbidden unless current_user.admin?
    retrieve_solution
  end

  def update
    return head :forbidden unless current_user.admin?
    retrieve_solution

    if @solution.update(solution_params)
      flash[:success] = %(#{I18n.t("solutions.success")} "#{@solution.title}")
      redirect_to solutions_path
    else
      render :edit
    end
  end

  def destroy
    return head :forbidden unless current_user.admin?
    retrieve_solution

    if @solution.destroy
      flash[:success] = I18n.t("solutions.success_deleted")
    else
      flash[:error] = I18n.t("solutions.error")
    end
    redirect_to solutions_path
  end

  def export
    return head :forbidden unless current_user.admin?

    rs= Decidim::Exporters.find_exporter('Excel').new(Solution.order(:created_at).all, SolutionsSerializer).export
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
    permitted= [:title, :team_name, :description, :explanation, :youtube_link, :github_link,
      :representative_email, :representative_first_name, :representative_last_name, :representative_phone_num,
      :web_url, :android_mkt_url, :ios_mkt_url,
      :firebase_shared, :firebase_url,
      :sd_goal_id, :file, {decidim_proposals_proposal_ids: []},
    ]
    params.require(:solution).permit(*permitted)
  end

  def retrieve_solution
    @solution= Solution.find(params[:id])
  end
end
