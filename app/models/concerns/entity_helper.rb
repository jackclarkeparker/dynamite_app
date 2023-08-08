module EntityHelper
  private

    def set_entity_id
      reference = EntityIDReference.first_or_create
      model = self.class.to_s
      reference.increment!(model)
      self.entity_id = reference.get_entity_id_for(model)
    end
end