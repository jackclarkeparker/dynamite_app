module SelectHelper
  def tutors_select(entity)
    tutors = Tutor.order(:first_name)
    select_components = tutors.map do |tutor|
      [tutor.preferred_name, tutor.id]
    end.unshift(['Tutor'])

    options_for_select(
      select_components,
      selected: entity.tutor || 'Tutor',
      disabled: 'Tutor'
    )
  end

  def venues_select(entity)
    venues = Venue.order(:name)
    select_components = venues.map do |venue|
      [venue.name, venue.id]
    end.unshift(['Venue'])

    options_for_select(
      select_components,
      selected: entity.venue || 'Venue',
      disabled: 'Venue'
    )
  end

  def week_day_select(entity)
    select_components = Date::DAYNAMES.map.with_index do |day, index|
      [day, index]
    end.unshift('Day')

    options_for_select(
      select_components,
      selected: entity.week_day_index || 'Day',
      disabled: 'Day'
    )
  end

  def regions_select(entity)
    regions = Region.order(:name)
    select_components = regions.map do |region|
      [region.name, region.id]
    end.unshift(['Region'])

    options_for_select(
      select_components,
      selected: entity.region || 'Region',
      disabled: 'Region'
    )
  end

  def gender_select(entity)
    options_for_select(
      ['Gender', 'male', 'female', 'other'], {
        selected: entity.gender || 'Gender',
        disabled: 'Gender'
      }
    )
  end
end