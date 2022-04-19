# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
Message.destroy_all
Booking.destroy_all
Event.destroy_all
Chatroom.destroy_all
User.destroy_all

url = "https://randomuser.me/api/?results=50"
users_data = JSON.parse(open(url).read)

address= ["1 Rue de la Légion d'Honneur", "Place Georges-Pompidou", "37 Quai Branly", "11 Av. du Président", "23 Rue de Sévigné", "5 Rue de Thorigny", "129 Rue de Grenelle", "77 Rue de Varenne", "10 Bd Montmartre", "63 Rue de Monceau"]
bio = ["I love being active!", "I love playing sports!", "I'm looking to make some new friends and play sports", "Looking to get in shape and have some fun!", "testing testing testing testing testing testing testing testinng testing"]

puts 'creating 50 fake users...'
users_data['results'].each do |user_data|
  user = User.new(
    first_name: user_data['name']['first'],
    last_name: user_data['name']['last'],
    email: user_data['email'],
    address: address.sample + " , Paris, France",
    password: '123456',
    bio: bio.sample
  )

  file = URI.open("#{user_data['picture']['large']}")
  user.photo.attach(io: file, filename: "#{user.first_name}.png", content_type: 'image/png')
  user.save!
end

puts "Creating 4 more users"
alice = User.create!(first_name: 'Alice', last_name: 'Monet', address: '38 rue de verneuil paris', email: 'alice@gmail.com', password:'123456', bio: "I love playing sports")
file = URI.open('http://ghost.skillshub.info/content/images/2017/01/profile-girl-square.png')
alice.photo.attach(io: file, filename: 'alice.png', content_type: 'image/png')

raoni = User.create!(first_name: 'Raoni', last_name: 'Pirat', address: '24 rue de sevres paris', email: 'jean@gmail.com', password:'123456', bio: "I love playing sports")
file = URI.open('https://media-exp1.licdn.com/dms/image/C4E03AQFl3h14nxUEvg/profile-displayphoto-shrink_400_400/0/1641928856269?e=1655942400&v=beta&t=Exfjjx_eoYCb9YhVDnqhlZIIvfpDT31RBL2pYIreu4Q')
raoni.photo.attach(io: file, filename: 'raoni.png', content_type: 'image/png')

jennifer = User.create!(first_name: 'Jennifer', last_name: 'Carrow', address: '20 rue du store paris', email: 'jennifer@gmail.com', password:'123456', bio: "I love playing sports")
file = URI.open('https://media-exp1.licdn.com/dms/image/C4D03AQGdUxB-dcF6KQ/profile-displayphoto-shrink_400_400/0/1641680245372?e=1655942400&v=beta&t=kNSBgg7eso-gZmSFbsrowSWdrAVslftndrTZ6BGXLZI')
jennifer.photo.attach(io: file, filename: 'jennifer.png', content_type: 'image/png')

brianna = User.create!(first_name: 'Brianna', last_name: 'London', address: '8 rue de verneuil paris', email: 'brianna@gmail.com', password:'123456', bio: "I love playing sports")
file = URI.open('https://media-exp1.licdn.com/dms/image/C5603AQEE2MXahFNkaw/profile-displayphoto-shrink_400_400/0/1517474598541?e=1651708800&v=beta&t=XHmnp9CtlvlFdeb7Tgk-Kqu8rYgqQhSRjlT7VAmgtCU')
brianna.photo.attach(io: file, filename: 'brianna.png', content_type: 'image/png')

level = ['Beginner', 'Intermediate', 'Advanced']
sport = ['Tennis', 'Football', 'Yoga', 'Soccer', 'Badminton', 'Running']
duration = ['1 hour', '2 hour']
event_name = ['Sport-acholic', 'Summer workout', 'Mindfulness with ME', 'Summer body get ready!']
event_pic = ['https://cloudfront-us-east-1.images.arcpublishing.com/advancelocal/R7DQ3DK3SJDLNPIDGZHMSNQC6Y.jpeg', 'https://apexindoorsports.com/wp-content/uploads/2018/06/adultSports.jpg']


puts 'Creating 50 events...'

alice_e1 = Event.new(event_name: "Women's Soccer", sport: 'Soccer', level: 'Beginner', date: Date.today+rand(90), duration: '1 hour')
alice_e1.user = alice
alice_e1.address = alice.address
event_file = URI.open(event_pic.sample)
alice_e1.photo.attach(io: event_file, filename: 'alice_e1.png', content_type: 'image/png')
alice_e1.save!


50.times do
  event = Event.new(
    user: User.all.sample,
    sport: sport.sample,
    level: level.sample,
    date: Date.today+rand(90),
    duration: duration.sample,
    address: address.sample + ", Paris, France",
    event_name: event_name.sample
  )

  event_file = URI.open('https://lifestylefrisco.com/wp-content/uploads/2018/04/Frisco-Chamber-Field-Day-6.jpg')
  event.photo.attach(io: event_file, filename: 'event.png', content_type: 'image/png')

  event.save!

end

20.times do
  chatroom = Chatroom.new(sender: User.all.sample, recepient: User.all.sample)
  chatroom.save!
end



puts "#{Event.count} events created"
