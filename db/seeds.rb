# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(
	name: "Example User",
	email: "example@railstutorial.org",
	password: "foobar",
	password_confirmation: "foobar",
	admin: true,
	activated: true,
	activated_at: Time.zone.now,
	picture: "admin.png")

99.times do |n|
	name  = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	picture = "ruby.jpeg"
	User.create!(name: name,
		email: email,
		password: password,
		password_confirmation: password,
		activated: true,
		activated_at: Time.zone.now,
		picture: picture)
end

Item.create!(
  name: "Ruby Gem",
  description: "A real Ruby Gem, the stone, not the software.",
  price: 1337.00
)

Item.create!(
  name: "Rails Set",
  description: "A set of metal Rails, used for railroads, not software.",
  price: 420.00
)

98.times do |n|
  	name  = Item.nameMaker
  	description = Faker::Lorem.sentence(1)
	price = Item.priceMaker
	item = Item.create!(
  		name: name,
  		description: description,
  		price: price)	
end