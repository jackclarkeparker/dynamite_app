module SlowlyChangingDimensionHelpers
  private

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
      old_version.update_attribute(:valid_until, decomission_timestamp)
    end
end