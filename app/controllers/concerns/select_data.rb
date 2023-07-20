module SelectData
  private

    def set_tutors
      @tutors = Tutor.order(:first_name)
    end

    def set_venues
      @venues = Venue.order(:name)
    end

    def set_regions
      @regions = Region.order(:name)
    end
end