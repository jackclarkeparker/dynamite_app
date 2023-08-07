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
      if !Venue.exists?(id: venue_id)
        errors.add(:venue, 'must be selected')
      end
    end

    def validate_student_id
      if !Student.exists?(id: student_id)
        errors.add(:student, 'must be selected')
      end
    end

    def validate_contact_id
      if !Contact.exists?(id: contact_id)
        errors.add(:contact, 'must be selected')
      end
    end

    def validate_lesson_id
      if !Lesson.exists?(id: lesson_id)
        errors.add(:lesson, 'must be selected')
      end
    end
end