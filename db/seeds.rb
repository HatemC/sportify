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


puts 'creating 50 fake users...'
users_data['results'].each do |user_data|
  user = User.new(
    first_name: user_data['name']['first'],
    last_name: user_data['name']['last'],
    address: "#{user_data['location']['street']['number']} #{user_data['location']['street']['namne']} #{user_data['location']['city']} #{user_data['location']['state']}
               #{user_data['location']['country']} #{user_data['location']['postcode']} ",
    email: user_data['email'],
    password: '123456'
  )

  file = URI.open("#{user_data['picture']['large']}")
  user.photo.attach(io: file, filename: "#{user.first_name}.png", content_type: 'image/png')
  user.save
end

puts 'Creating 6 more users'
alice = User.create!(first_name: 'Alice', last_name: 'Monet', address: '38 rue de verneuil paris', email: 'alice@gmail.com', password:'123456')
file = URI.open('http://ghost.skillshub.info/content/images/2017/01/profile-girl-square.png')
alice.photo.attach(io: file, filename: 'alice.png', content_type: 'image/png')

jean = User.create!(first_name: 'Jean', last_name: 'Dupont', address: '24 rue de sevres paris', email: 'jean@gmail.com', password:'123456')
file = URI.open('https://media.istockphoto.com/photos/side-view-longbeard-business-man-portrait-picture-id1074638206?k=20&m=1074638206&s=612x612&w=0&h=ORoK2wMFc7AaE-femw7qRI1l5diwMHTqm4PeaKyTLo0=')
jean.photo.attach(io: file, filename: 'jean.png', content_type: 'image/png')

chloe = User.create!(first_name: 'Chloe', last_name: 'Barbeau', address: '20 rue du store paris', email: 'chloe@gmail.com', password:'123456')
file = URI.open('https://media.istockphoto.com/photos/young-african-woman-smiling-at-sunset-picture-id969233490?k=20&m=969233490&s=612x612&w=0&h=jXLgjbu0CIWEohHgcx_ZHBhrcH3hNKcg7TVJgehndPg=')
chloe.photo.attach(io: file, filename: 'chloe.png', content_type: 'image/png')

jacques = User.create!(first_name: 'Jacques', last_name: 'Dupont', address: '24 rue du temple paris', email: 'jacques@gmail.com', password:'123456')
caroline = User.create!(first_name: 'Caroline', last_name: 'Martin', address: '20 boulevard saint-germain 75006 paris', email: 'caroline@gmail.com', password:'123456')
puts "#{User.count} users created"

brianna = User.create!(first_name: 'Brianna', last_name: 'London', address: '8 rue de verneuil paris', email: 'brianna@gmail.com', password:'123456')
file = URI.open('https://media-exp1.licdn.com/dms/image/C5603AQEE2MXahFNkaw/profile-displayphoto-shrink_400_400/0/1517474598541?e=1651708800&v=beta&t=XHmnp9CtlvlFdeb7Tgk-Kqu8rYgqQhSRjlT7VAmgtCU')
brianna.photo.attach(io: file, filename: 'brianna.png', content_type: 'image/png')


level = ['Beginner', 'Intermediate', 'Advanced']
sport = ['Tennis', 'Football', 'Yoga', 'Soccer', 'Badminton', 'Running']

puts 'Creating 20 offers...'

20.times do
  event = Event.new(
    user: User.all.sample,
    level: level.sample,
    date: Date.today+rand(90),

    duration: duration.sample,
    address: "#{Faker::Address.building_number} #{Faker::Address.street_name}, #{Faker::Address.country_by_code(code: 'FR')}",
  )
  event.save!
end

puts 'creating 3 more non faker events'

alice_event = Offer.new(sport: 'Tennis', level: 'Advanced', date: '09 May 2022')
alice_event.user = alice
alice_event.address = alice.address
alice_event.save!

jean_event = Offer.new(language: 'French', level: 'Native', date: 'Monday', duration: '1 hour')
jean_event.user = jean
jean_event.address = jean.address
jean_event.save!

chloe_event = Offer.new(language: 'French', level: 'Native', date: 'Monday', duration: '1 hour')
chloe_event.user = chloe
chloe_event.address = chloe.address
chloe_event.save!

puts "#{Event.count} events created"
