# frozen_string_literal: true

module ApplicationHelper
  def ods_options
    @ods_options ||= SDGoal.all.map { |ods| [ods.try(:id).to_s + ". " + translated_attribute(ods.name), ods.id] }
  end
  def must_render_countdown?
    DateTime.current < Time.zone.parse('2020-04-13 01:00:00')
  end
end
