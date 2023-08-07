# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

StudentContact.delete_all
LessonMember.unscoped.delete_all
Contact.delete_all
Student.delete_all
Lesson.delete_all
Tutor.unscoped.delete_all
Venue.delete_all
Region.delete_all

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
    region_id: wellington.id,
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
    region_id: wellington.id,
    entity_id: 2,
    valid_until: ApplicationRecord::FUTURE_EPOCH,
  },
])

lessons = Lesson.create!([
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 1,
    start_time: '16:00:00',
    end_time: '16:30:00',
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
    end_time: '17:00:00',
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
    end_time: '17:30:00',
    capacity: 4,
    availability: 2,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 1,
    start_time: '15:30:00',
    end_time: '16:00:00',
    capacity: 4,
    availability: 1,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: natalie.id,
    venue_id: newtown.id,
    week_day_index: 4,
    start_time: '09:20:00',
    end_time: '09:50:00',
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
    end_time: '10:25:00',
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
    end_time: '11:00:00',
    capacity: 4,
    availability: 0,
    duration: 30,
    standard_price: 16,
  },
  {
    tutor_id: natalie.id,
    venue_id: miramar.id,
    week_day_index: 2,
    start_time: '15:45:00',
    end_time: '16:15:00',
    capacity: 4,
    availability: 0,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: natalie.id,
    venue_id: miramar.id,
    week_day_index: 2,
    start_time: '15:15:00',
    end_time: '15:45:00',
    capacity: 4,
    availability: 0,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: natalie.id,
    venue_id: miramar.id,
    week_day_index: 2,
    start_time: '16:15:00',
    end_time: '16:45:00',
    capacity: 4,
    availability: 0,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: natalie.id,
    venue_id: miramar.id,
    week_day_index: 2,
    start_time: '16:45:00',
    end_time: '17:05:00',
    capacity: 1,
    availability: 0,
    duration: 20,
    standard_price: 26,
  },
  {
    tutor_id: natalie.id,
    venue_id: miramar.id,
    week_day_index: 2,
    start_time: '17:05:00',
    end_time: '17:35:00',
    capacity: 4,
    availability: 2,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 4,
    start_time: '15:30:00',
    end_time: '16:00:00',
    capacity: 4,
    availability: 1,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 4,
    start_time: '16:00:00',
    end_time: '16:30:00',
    capacity: 4,
    availability: 1,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 4,
    start_time: '16:30:00',
    end_time: '17:00:00',
    capacity: 4,
    availability: 1,
    duration: 30,
    standard_price: 16.5,
  },
  {
    tutor_id: andy.id,
    venue_id: miramar.id,
    week_day_index: 4,
    start_time: '17:00:00',
    end_time: '17:30:00',
    capacity: 4,
    availability: 1,
    duration: 30,
    standard_price: 16.5,
  },
])

joel, alice = Student.create!([
  {
    first_name: 'Joel',
    last_name: 'Sandwich',
    full_name: 'Joel Sandwich',
    preferred_name: '',
    age: 10,
    birthday: '2013-04-13',
    year_group: 6,
    gender: 'male',
    region_id: wellington.id,
    keyboard: 'Keyboard',
  },
  {
    first_name: 'Alice',
    last_name: 'Dewie',
    full_name: 'Alice Dewie',
    preferred_name: '',
    age: 7,
    birthday: '2016-02-20',
    year_group: 3,
    gender: 'female',
    region_id: wellington.id,
    keyboard: 'Touch-sensitive Keyboard',
  }
])

dennis, winona = Contact.create!([
  {
    first_name: 'Dennis',
    last_name: '',
    full_name: '',
    preferred_name: '',
    email_address: 'dennis@email.com',
    phone_number: '',
    bank_account: '',
    csc_number: '',
    valid_until: ApplicationRecord::FUTURE_EPOCH,
    entity_id: 1,
    region_id: wellington.id,
  },
  {
    first_name: 'Winona',
    last_name: 'Dewie',
    full_name: 'Winona Dewie',
    preferred_name: 'Win',
    email_address: 'Winona@email.com',
    phone_number: '027 567 1234',
    bank_account: '12 1234 1234567 123',
    csc_number: '123 456 789',
    valid_until: ApplicationRecord::FUTURE_EPOCH,
    entity_id: 2,
    region_id: wellington.id,
  }
])

StudentContact.create!([
  {
    student_id: joel.id,
    contact_id: dennis.id,
    contact_relation: 'Dad',
    primary_contact: true,
    account_holder: '',
  },
  {
    student_id: alice.id,
    contact_id: winona.id,
    contact_relation: 'Mum',
    primary_contact: true,
    account_holder: true,
  },
])

LessonMember.create!([
  {
    lesson_id: lessons[0].id,
    student_id: joel.id,
    valid_until: ApplicationRecord::FUTURE_EPOCH,
  },
])