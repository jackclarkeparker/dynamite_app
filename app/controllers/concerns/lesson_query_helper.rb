module LessonQueryHelper
  extend ActiveSupport::Concern

  private

    def lessons_by_venue_by_day(other_includes: [])
      Lesson.includes(:venue, *other_includes).order(
        'venues.name', :week_day_index, :start_time
      ).reduce({}) do |schedule, l|
        schedule[l.venue.name] ||= {}
        schedule[l.venue.name][l.day] ||= []
        schedule[l.venue.name][l.day] << l
        schedule
      end
      # This implementation is a bit messy...
      # And it doesn't handle regions
      # If we end up using some filters, we may ditch this
      # for something else anyway.
    end
end