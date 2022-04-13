# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
Booking.destroy_all
Event.destroy_all
User.destroy_all

url = "https://randomuser.me/api/?results=50"
users_data = JSON.parse(open(url).read)

bio = ["I love being active!", "I love playing sports!", "I'm looking to make some new friends and play sports", "Looking to get in shape and have some fun!"]

puts 'creating 50 fake users...'
users_data['results'].each do |user_data|
  user = User.new(
    first_name: user_data['name']['first'],
    last_name: user_data['name']['last'],
    address: "#{user_data['location']['street']['number']} #{user_data['location']['street']['namne']} #{user_data['location']['city']} #{user_data['location']['state']}
               #{user_data['location']['country']} #{user_data['location']['postcode']} ",
    email: user_data['email'],
    address: "#{Faker::Address.building_number} #{Faker::Address.street_name}, #{Faker::Address.country_by_code(code: 'FR')}",
    password: '123456',
    bio: bio.sample
  )

  file = URI.open("#{user_data['picture']['large']}")
  user.photo.attach(io: file, filename: "#{user.first_name}.png", content_type: 'image/png')
  user.save
end



level = ['Beginner', 'Intermediate', 'Advanced']
sport = ['Tennis', 'Football', 'Yoga', 'Soccer', 'Badminton', 'Running']
duration = ['1 hour', '2 hour']

puts 'Creating 20 events...'


20.times do
  event = Event.new(
    user: User.all.sample,
    sport: sport.sample,
    level: level.sample,
    sport:  sport.sample,
    date: Date.today+rand(90),
    duration: duration.sample,
    address: "19 Rue des Petits Champs"
    # address: "#{Faker::Address.building_number} #{Faker::Address.street_name}, #{Faker::Address.country_by_code(code: 'FR')}",
  )
  event.save!
end

puts "#{Event.count} events created"
