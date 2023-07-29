module SlowlyChangingDimensionHelpers
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

    -> If the entity record can only be deleted if all records that reference it are also
       deleted, then I suppose it's not a problem. I could probably use a database index
       or something though... I can ask GPT about it at some point.
=end

    def decomission_old_version(old_version, decomission_timestamp:)
      old_version.valid_until = decomission_timestamp
      old_version.save
    end
end