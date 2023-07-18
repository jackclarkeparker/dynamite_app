module EntityHelpers
  private

    def set_entity_id(instance)
      all_records = instance.class.all

      if all_records.empty?
        instance.entity_id = 1
      else
        current_highest = all_records.max_by { |m| m.entity_id }.entity_id
        instance.entity_id = current_highest + 1
      end
    end

=begin
    Note: If we ever delete any entity records from the database,
          #set_entity_id could easily assign an entity_id to a new entity
          instance that previously was assigned to a now deleted entity
          instance.
=end
end