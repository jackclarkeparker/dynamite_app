# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Lesson.delete_all
Region.delete_all
Venue.delete_all
Tutor.delete_all

wellington, new_plymouth = Region.create!([{ name: 'Wellington' }, { name: 'New Plymouth' }])

miramar, newtown = Venue.create!([
  {
    name: 'Miramar Community Centre',
    address: '27 Chelsea Street, Miramar, Wellington 6022',
    region_id: wellington.id,
    standard_price: 16.5,
  },
  {
    name: 'Newtown School',
    address: 'Mein Street',
    region_id: wellington.id,
    standard_price: 16,
  }
])

andy, natalie = Tutor.create!([
  {
    preferred_name: 'Andy',
    first_name: 'Andrew',
    last_name: 'Taylor',
    full_name: 'Andrew Taylor',
    email_address: 'andy@dynamitemusic.co.nz',
    phone_number: '021 123 4567',
    delivery_address: '13 Clyde Street, Island Bay, 6023',
    entity_id: 1,
    valid_until: ApplicationRecord::FUTURE_EPOCH,
  },
  {
    preferred_name: 'Natalie',
    first_name: 'Natalie',
    last_name: 'Jones',
    full_name: 'Natalie Jones',
    email_address: 'natalie@dynamitemusic.co.nz',
    phone_number: '021 765 4321',
    delivery_address: '18 Blackbridge Road, Wadestown, 6012',
    entity_id: 2,
    valid_until: ApplicationRecord::FUTURE_EPOCH,
  },
])

Lesson.create!([
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 1,
    start_time: '15:30:00',
    capacity: 4,
    availability: 1,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 1,
    start_time: '16:00:00',
    capacity: 4,
    availability: 0,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 1,
    start_time: '16:30:00',
    capacity: 3,
    availability: 0,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 1,
    start_time: '17:00:00',
    capacity: 4,
    availability: 2,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: natalie.id,
    venue_id: newtown.id,
    week_day_index: 4,
    start_time: '09:20:00',
    capacity: 4,
    availability: 0,
    duration: 30,
    standard_price: 16,
  },
  {
    tutor_id: natalie.id,
    venue_id: newtown.id,
    week_day_index: 4,
    start_time: '09:55:00',
    capacity: 4,
    availability: 1,
    duration: 30,
    standard_price: 16,
  },
  {
    tutor_id: natalie.id,
    venue_id: newtown.id,
    week_day_index: 4,
    start_time: '10:30:00',
    capacity: 4,
    availability: 0,
    duration: 30,
    standard_price: 16,
  },
])