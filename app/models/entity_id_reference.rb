class EntityIDReference < ApplicationRecord
  def increment!(model)
    case model
    when 'Contact' then self.contact_entity_id += 1
    when 'Tutor'   then self.tutor_entity_id += 1
    end

    save
  end

  def get_entity_id_for(model)
    case model
    when 'Contact' then contact_entity_id
    when 'Tutor'   then tutor_entity_id
    end
  end
end
