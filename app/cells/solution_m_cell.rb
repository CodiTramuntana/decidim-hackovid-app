# frozen_string_literal: true

require "cell/partial"

# This cell renders a Solution with its M-size card.
#
# Check out the structure of a card_m cell at:
# https://github.com/decidim/decidim/tree/develop/decidim-core/app/cells/decidim
class SolutionMCell < Decidim::CardMCell

  private

  def title
    decidim_html_escape(model.title)
  end

  def body
    decidim_html_escape(model.description)
  end


  private

  def has_label?; true end
  def label
    translated_attribute(model.sd_goal.name)
  end

  def render_top?; true end
  def top
    'TOP'
  end

  def has_image?; true end
  def image
    'IMG'
  end

  def resource_path
    solutions_path
  end

  # def has_state?
  #   model.published?
  # end

  # def has_badge?
  #   published_state? || withdrawn?
  # end

  # def has_link_to_resource?
  #   model.published?
  # end

  # def has_footer?
  #   return false if model.emendation?

  #   true
  # end

  # def description
  #   strip_tags(body).truncate(100, separator: /\s/)
  # end

  # def badge_classes
  #   return super unless options[:full_badge]

  #   state_classes.concat(["label", "proposal-status"]).join(" ")
  # end

  # def statuses
  #   return [:endorsements_count, :comments_count] if model.draft?
  #   return [:creation_date, :endorsements_count, :comments_count] if !has_link_to_resource? || !can_be_followed?

  #   [:creation_date, :follow, :endorsements_count, :comments_count]
  # end

  # def creation_date_status
  #   l(model.published_at.to_date, format: :decidim_short)
  # end

  # def endorsements_count_status
  #   return endorsements_count unless has_link_to_resource?

  #   link_to resource_path do
  #     endorsements_count
  #   end
  # end

  # def endorsements_count
  #   with_tooltip t("decidim.endorsable.endorsements") do
  #     icon("bullhorn", class: "icon--small") + " " + model.endorsements_count.to_s
  #   end
  # end

  # def progress_bar_progress
  #   model.proposal_votes_count || 0
  # end

  # def progress_bar_total
  #   model.maximum_votes || 0
  # end

  # def progress_bar_subtitle_text
  #   if progress_bar_progress >= progress_bar_total
  #     t("decidim.proposals.proposals.votes_count.most_popular_proposal")
  #   else
  #     t("decidim.proposals.proposals.votes_count.need_more_votes")
  #   end
  # end

  # def can_be_followed?
  #   !model.withdrawn?
  # end

  # def has_image?
  #   model.attachments.first.present? && model.attachments.first.file.content_type.start_with?("image") && model.component.settings.allow_card_image
  # end

  # def resource_image_path
  #   model.attachments.first.url if has_image?
  # end
end
