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

address = ["1 Rue de la Légion d'Honneur", "Place Georges-Pompidou", "37 Quai Branly", "11 Av. du Président", "23 Rue de Sévigné", "5 Rue de Thorigny", "129 Rue de Grenelle", "77 Rue de Varenne", "10 Bd Montmartre", "63 Rue de Monceau"]
bio = "I love being active! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Semper eget duis at tellus."

puts 'creating 50 fake users...'
users_data['results'].each do |user_data|
  user = User.new(
    first_name: user_data['name']['first'],
    last_name: user_data['name']['last'],
    email: user_data['email'],
    address: address.sample + " , Paris, France",
    password: '123456',
    bio: bio
  )

  file = URI.open("#{user_data['picture']['large']}")
  user.photo.attach(io: file, filename: "#{user.first_name}.png", content_type: 'image/png')
  user.save!
end

puts "Creating 4 more users"
alice = User.create!(first_name: 'Alice', last_name: 'Monet', address: '38 rue de verneuil paris', email: 'alice@gmail.com', password:'123456', bio: "My name is Alice and I love playing sports! I enjoy playing soccer and soccer on the weekends. Can't wait to play together!")
file = URI.open('http://ghost.skillshub.info/content/images/2017/01/profile-girl-square.png')
alice.photo.attach(io: file, filename: 'alice.png', content_type: 'image/png')

raoni = User.create!(first_name: 'Raoni', last_name: 'Pirat', address: '24 rue de sevres paris', email: 'jean@gmail.com', password:'123456', bio: "My name is Raoni and I love staying active. I enjoy playing tennis and soccer on the weekends. Can't wait to play together!")
file = URI.open('https://media-exp1.licdn.com/dms/image/C4E03AQFl3h14nxUEvg/profile-displayphoto-shrink_400_400/0/1641928856269?e=1655942400&v=beta&t=Exfjjx_eoYCb9YhVDnqhlZIIvfpDT31RBL2pYIreu4Q')
raoni.photo.attach(io: file, filename: 'raoni.png', content_type: 'image/png')

jennifer = User.create!(first_name: 'Jennifer', last_name: 'Carrow', address: '20 rue du store paris', email: 'jennifer@gmail.com', password:'123456', bio: "My name is Jennifer and I love staying active and meeting new people. My favorite sports are softball, tennis and badminton. Can't wait to play together!")
file = URI.open('https://media-exp1.licdn.com/dms/image/C4D03AQGdUxB-dcF6KQ/profile-displayphoto-shrink_400_400/0/1641680245372?e=1655942400&v=beta&t=kNSBgg7eso-gZmSFbsrowSWdrAVslftndrTZ6BGXLZI')
jennifer.photo.attach(io: file, filename: 'jennifer.png', content_type: 'image/png')

brianna = User.create!(first_name: 'Brianna', last_name: 'London', address: '8 rue de verneuil paris', email: 'brianna@gmail.com', password:'123456', bio: "My name is Brianna and I love staying active. I love soccer, running and yoga :) Can't wait to play together!")
file = URI.open('https://media-exp1.licdn.com/dms/image/C5603AQEE2MXahFNkaw/profile-displayphoto-shrink_400_400/0/1517474598541?e=1651708800&v=beta&t=XHmnp9CtlvlFdeb7Tgk-Kqu8rYgqQhSRjlT7VAmgtCU')
brianna.photo.attach(io: file, filename: 'brianna.png', content_type: 'image/png')

level = ['Beginner', 'Intermediate', 'Advanced']
sport = ['Tennis', 'Football', 'Yoga', 'Soccer', 'Badminton', 'Running']
duration = ['1 hour', '2 hour']
event_name = ['Sport-acholic', 'Summer Workout','Summer body get ready!', 'Morning Workout', "Evening Workout"]
tennis_pic = ["https://cdn.pixabay.com/photo/2021/06/04/06/54/racket-6308994_1280.jpg", "https://cdn.pixabay.com/photo/2020/11/27/18/59/tennis-5782695__480.jpg", "https://www.usta.com/content/dam/usta/Articles/article-primary/20190411_USTA_RW_2892-socialleagues-1170x585.jpg"]
football_pic = ["https://www.imgacademy.com/sites/default/files/styles/scale_1700w/public/2019-11/160_90_photo_shoot_2019_football_m357817.jpg?itok=jtsRrhsN", "https://upload.wikimedia.org/wikipedia/commons/0/02/American_football-Centurions_Nimes_vs_Hurricanes_Montpellier_U17-terrain_La_Bastide.JPG", "https://media.istockphoto.com/photos/man-carrying-ball-avoids-defender-in-recreational-flag-football-game-picture-id1326514135?k=20&m=1326514135&s=612x612&w=0&h=sDReM9nt8sZiNX0an9R0Dctcj8tV67S1eFXQ2clnOJ4="]
yoga_pic = ["https://ak.picdn.net/shutterstock/videos/1017354571/thumb/9.jpg", "https://media.istockphoto.com/photos/women-exercising-in-fitness-studio-yoga-classes-picture-id1162518512?k=20&m=1162518512&s=612x612&w=0&h=bmw0znjI2GkbC9tgDaFSQdsem087084J5aNM-X6iDa0=", "https://media.istockphoto.com/photos/group-of-women-practicing-yoga-ardha-matsyendrasana-pose-picture-id1076946974?k=20&m=1076946974&s=612x612&w=0&h=qc-BGvEUvMxQCfqeCMvw-PAIXNEjLKHCevVXdp-lC0E=" ]
soccer_pic = ["https://www.vernonmorningstar.com/wp-content/uploads/2017/08/8131737_web1_Co-ed-8.jpg", "https://cdn.pixabay.com/photo/2016/06/15/01/11/soccer-1457988__340.jpg", "https://www.marcadorint.com/wp-content/uploads/2019/11/67125107_2323159601113809_212292468140408832_o.jpg" ]
badminton_pic = ["https://img.olympicchannel.com/images/image/private/t_16-9_360-203_2x/f_auto/v1538355600/primary/kfsyzuaoipfhm4qonqci", "https://static.toiimg.com/thumb/msid-83229866,width-1200,height-900,resizemode-4/.jpg"]
running_pic = ["https://ak.picdn.net/shutterstock/videos/15332308/thumb/1.jpg", "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/female-running-friends-royalty-free-image-1642534924.jpg?crop=0.668xw:1.00xh;0.233xw,0&resize=640:*", "https://apexindoorsports.com/wp-content/uploads/2018/06/adultSports.jpg", "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/thumbnail-running-01-1492707760.jpg"]

description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Semper eget duis at tellus. Congue nisi vitae suscipit tellus mauris a. Ultricies tristique nulla aliquet enim tortor at auctor urna. Ultrices eros in cursus turpis massa tincidunt dui. Tellus integer feugiat scelerisque varius morbi. Odio eu feugiat pretium nibh. Aliquam malesuada bibendum arcu vitae elementum curabitur vitae nunc."

puts 'Creating 67 new events...'

alice_e1 = Event.new(event_name: "Women's Soccer", sport: 'Soccer', level: 'Beginner', date: Date.today+rand(90), duration: '1 hour', description: description)
alice_e1.user = alice
alice_e1.address = alice.address
event_file = URI.open("https://cloudfront-us-east-1.images.arcpublishing.com/advancelocal/R7DQ3DK3SJDLNPIDGZHMSNQC6Y.jpeg")
alice_e1.photo.attach(io: event_file, filename: 'alice_e1.png', content_type: 'image/png')
alice_e1.save!

raoni_e1 = Event.new(event_name: "Sunset Run", sport: 'Running', level: 'Beginner', date: Date.today, duration: '1 hour', description: description)
raoni_e1.user = raoni
raoni_e1.address = raoni.address
event_file = URI.open("https://frenchly.us/wp-content/uploads/sites/9/2018/08/runners-in-paris2.jpg")
raoni_e1.photo.attach(io: event_file, filename: 'raoni_e21.png', content_type: 'image/png')
raoni_e1.save!

alice_e2 = Event.new(event_name: "Yoga in the Park", sport: 'Yoga', level: 'Beginner', date: Date.today+rand(90), duration: '1 hour', description: description)
alice_e2.user = alice
alice_e2.address = alice.address
event_file = URI.open("https://images.squarespace-cdn.com/content/v1/5b0e12a8697a98669b4339eb/1540867709901-GI1CJJEEQP628Q06NV0J/fullsizeoutput_1d44.jpeg?format=1000w")
alice_e2.photo.attach(io: event_file, filename: 'alice_e2.png', content_type: 'image/png')
alice_e2.save!

alice_e3 = Event.new(event_name: "Women's Football/Rugby", sport: 'Football', level: 'Beginner', date: Date.today, duration: '1 hour', description: description)
alice_e3.user = alice
alice_e3.address = alice.address
event_file = URI.open("https://i.ytimg.com/vi/teUcpvtFCeY/hqdefault.jpg")
alice_e3.photo.attach(io: event_file, filename: 'alice_e3.png', content_type: 'image/png')
alice_e3.save!

10.times do
  event = Event.new(
    user: User.all.sample,
    sport: 'Soccer',
    level: level.sample,
    date: Date.today+rand(90),
    duration: duration.sample,
    address: address.sample + ", Paris, France",
    event_name: event_name.sample,
    description: description
  )

  event_file = URI.open(soccer_pic.sample)
  event.photo.attach(io: event_file, filename: 'event.png', content_type: 'image/png')

  event.save!
end

10.times do
  event = Event.new(
    user: User.all.sample,
    sport: 'Yoga',
    level: level.sample,
    date: Date.today+rand(30),
    duration: duration.sample,
    address: address.sample + ", Paris, France",
    event_name: event_name.sample,
    description: description
  )

  event_file = URI.open(yoga_pic.sample)
  event.photo.attach(io: event_file, filename: 'event.png', content_type: 'image/png')

  event.save!
end

10.times do
  event = Event.new(
    user: User.all.sample,
    sport: 'Football',
    level: level.sample,
    date: Date.today+rand(60),
    duration: duration.sample,
    address: address.sample + ", Paris, France",
    event_name: event_name.sample,
    description: description
  )

  event_file = URI.open(football_pic.sample)
  event.photo.attach(io: event_file, filename: 'event.png', content_type: 'image/png')

  event.save!
end

10.times do
  event = Event.new(
    user: User.all.sample,
    sport: 'Badminton',
    level: level.sample,
    date: Date.today+rand(90),
    duration: duration.sample,
    address: address.sample + ", Paris, France",
    event_name: event_name.sample,
    description: description
  )

  event_file = URI.open(badminton_pic.sample)
  event.photo.attach(io: event_file, filename: 'event.png', content_type: 'image/png')

  event.save!
end

10.times do
  event = Event.new(
    user: User.all.sample,
    sport: 'Tennis',
    level: level.sample,
    date: Date.today+rand(90),
    duration: duration.sample,
    address: address.sample + ", Paris, France",
    event_name: event_name.sample,
    description: description
  )

  event_file = URI.open(tennis_pic.sample)
  event.photo.attach(io: event_file, filename: 'event.png', content_type: 'image/png')

  event.save!
end

10.times do
  event = Event.new(
    user: User.all.sample,
    sport: 'Running',
    level: level.sample,
    date: Date.today+rand(30),
    duration: duration.sample,
    address: address.sample + ", Paris, France",
    event_name: event_name.sample,
    description: description
  )

  event_file = URI.open(running_pic.sample)
  event.photo.attach(io: event_file, filename: 'event.png', content_type: 'image/png')

  event.save!
end

brianna_e1 = Event.new(event_name: "Yoga & Meditation", sport: 'Yoga', level: 'Beginner', date: Date.today, duration: '1 hour', description: description)
brianna_e1.user = brianna
brianna_e1.address = brianna.address
event_file = URI.open("https://media.istockphoto.com/photos/women-in-meditation-while-practicing-yoga-in-a-training-room-happy-picture-id1166417394?k=20&m=1166417394&s=612x612&w=0&h=LK4GrdXUX-I6dfrHsfAzStFOaS1zyRUMuNIx7kD7JtM=")
brianna_e1.photo.attach(io: event_file, filename: 'brianna_e1.png', content_type: 'image/png')
brianna_e1.save!

brianna_e2 = Event.new(event_name: "Yoga & Pilates", sport: 'Yoga', level: 'Beginner', date: Date.today+rand(30), duration: '1 hour', description: description)
brianna_e2.user = brianna
brianna_e2.address = brianna.address
event_file = URI.open("https://media.istockphoto.com/photos/young-woman-practicing-yoga-paripurna-navasana-exercise-with-a-ring-picture-id1076946904?k=20&m=1076946904&s=612x612&w=0&h=z-mNO5EifVlR24ShXdAP_ooQxnGY84x4_m9U_SmqIt8=")
brianna_e2.photo.attach(io: event_file, filename: 'brianna_e1.png', content_type: 'image/png')
brianna_e2.save!

brianna_e2 = Event.new(event_name: "Soccer in the Park", sport: 'Soccer', level: 'Beginner', date: Date.today+rand(30), duration: '1 hour', description: description)
brianna_e2.user = brianna
brianna_e2.address = brianna.address
event_file = URI.open("https://media.istockphoto.com/photos/young-woman-practicing-yoga-paripurna-navasana-exercise-with-a-ring-picture-id1076946904?k=20&m=1076946904&s=612x612&w=0&h=z-mNO5EifVlR24ShXdAP_ooQxnGY84x4_m9U_SmqIt8=")
brianna_e2.photo.attach(io: event_file, filename: 'brianna_e1.png', content_type: 'image/png')
brianna_e2.save!

20.times do
  chatroom = Chatroom.new(sender: User.all.sample, recepient: User.all.sample)
  chatroom.save!
end

puts "#{Event.count} events created"
