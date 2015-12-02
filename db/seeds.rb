# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: 'TurtleShip',
             email: 'seulgi.kim.56@outlook.com',
             firstname: 'Seulgi',
             lastname: 'Kim',
             password: 'password',
             password_confirmation: 'password',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

100.times do |id|
  username = "#{Faker::Internet.user_name(specifier=nil, separators = %w(-_))[0..10]}_#{id}"
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = "example-#{id+1}@railstutorial.org"
  password = 'password'
  puts "username : #{username}, firstname : #{firstname}, lastname : #{lastname}"
  User.create!(username: "#{username}_#{id}",
               email: email,
               firstname: firstname,
               lastname: lastname,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

Contest.create!(
    name: 'Codeforces',
    url: 'http://codeforces.com',
    description: 'The only programming contests on Web 2.0 platform.'
)

Contest.create!(
    name: 'TopCoder',
    url: 'http://www.topcoder.com',
    description: 'A vendor-neutral coding competition site'
)