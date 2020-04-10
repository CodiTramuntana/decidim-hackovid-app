# frozen_string_literal: true

module ApplicationHelper
  def ods_options
    @ods_options ||= SDGoal.all.map { |ods| [ods.try(:id).to_s + ". " + translated_attribute(ods.name), ods.id] }
  end
end
