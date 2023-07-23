module RelatedModelValidator
  private

    def validate_region_id
      if !Region.exists?(id: region_id)
        errors.add(:region, 'must be selected')
      end
    end

    def validate_tutor_id
      if !Tutor.exists?(id: tutor_id)
        errors.add(:tutor, 'must be selected')
      end
    end

    def validate_venue_id
      if !Tutor.exists?(id: venue_id)
        errors.add(:venue, 'must be selected')
      end
    end
end