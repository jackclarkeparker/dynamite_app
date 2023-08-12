module SlowlyChangingDimensionHelpers
  private

    def decomission_old_version(old_version, decomission_timestamp:)
      old_version.update_attribute(:valid_until, decomission_timestamp)
    end
end