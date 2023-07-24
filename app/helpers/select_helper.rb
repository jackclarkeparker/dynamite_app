module SelectHelper
  def tutors_select(entity)
    tutors = Tutor.order(:first_name)
                  .where(valid_until: ApplicationRecord::FUTURE_EPOCH)
    select_components = tutors.map do |tutor|
      [tutor.preferred_name, tutor.id]
    end.unshift(['Tutor'])

    options_for_select(
      select_components,
      selected: default_select_option(:tutor_id, entity, 'Tutor'),
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
      selected: default_select_option(:venue_id, entity, 'Venue'),
      disabled: 'Venue'
    )
  end

  def week_day_select(entity)
    select_components = Date::DAYNAMES.map.with_index do |day, index|
      [day, index]
    end.unshift('Day')

    options_for_select(
      select_components,
      selected: default_select_option(:week_day_index, entity, 'Day'),
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
      selected: default_select_option(:region_id, entity, 'Region'),
      disabled: 'Region'
    )
  end

  def gender_select(entity)
    options_for_select(
      ['Gender', 'male', 'female', 'other'], {
        selected: default_select_option(:gender, entity, 'Gender'),
        disabled: 'Gender'
      }
    )
  end

  private

    def default_select_option(attribute, entity, simple_string)
      entity_symbol = to_symbol(entity)

      params[entity_symbol] && params[entity_symbol][attribute] ||
      entity.send(attribute) ||
      simple_string
    end

    def to_symbol(entity)
      class_name = entity.class.to_s
      with_underscores = underscores_between_class_name_components(class_name)
      with_underscores.downcase.to_sym
    end

    def underscores_between_class_name_components(class_name)
      class_name.gsub(/(.)([A-Z])/, '\1_\2')
    end
end