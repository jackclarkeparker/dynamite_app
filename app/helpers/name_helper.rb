module NameHelper
  def preferred_name_if_present(entity)
    entity.preferred_name.present? ? entity.preferred_name : entity.first_name
  end
end