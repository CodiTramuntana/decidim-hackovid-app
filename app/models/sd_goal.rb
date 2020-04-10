class SDGoal < ApplicationRecord

  def translatted_name
    name[I18n.locale.to_s]
  end
end
