class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Timestamp set for valid_until column's, indicating the given record
  # is the one representing the most up to date version of the entity.
  FUTURE_EPOCH = Time.new(9999, 12, 31)
end
