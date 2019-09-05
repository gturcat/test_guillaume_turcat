# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Request.destroy_all
puts 'destroy all Request'
puts 'creating Request'
r1 = Request.create(name: 'Guillaume1', email: 'gturcat1@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r1.confirmed!
r2 = Request.create(name: 'Guillaume2', email: 'gturcat2@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r2.confirmed!
r3 = Request.create(name: 'Guillaume3', email: 'gturcat3@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r3.confirmed!
r4 = Request.create(name: 'Guillaume4', email: 'gturcat4@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r4.confirmed!
r5 = Request.create(name: 'Guillaume5', email: 'gturcat5@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r5.confirmed!
r6 = Request.create(name: 'Guillaume6', email: 'gturcat6@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r6.confirmed!
r7 = Request.create(name: 'Guillaume7', email: 'gturcat7@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r7.confirmed!
r8 = Request.create(name: 'Guillaume8', email: 'gturcat8@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r8.confirmed!
r9 = Request.create(name: 'Guillaume9', email: 'gturcat9@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r9.confirmed!
r10 = Request.create(name: 'Guillaume10', email: 'gturcat10@me.com', phone_number: "07.13.07.24.16", bio: "aaaaaaaaaaaaaaaaaaaaaa")
r10.confirmed!


r3.date_status = '19/01/2019'
r3.save

r5.date_status = '19/01/2019'
r5.save

r7.date_status = '19/01/2019'
r7.save


Desk.destroy_all
puts 'destroy all desk'
puts 'creating Desk'
d1 = Desk.create(name: "Bureau 1", color:'red')
d2 = Desk.create(name: "Bureau 2", color: 'blue')
d3 = Desk.create(name: "Bureau 3", color: 'yellow')
d4 = Desk.create(name: "Bureau 4", color: 'orange')
d5 = Desk.create(name: "Bureau 5", color: 'purple')

User.destroy_all
puts 'destroy all users'
puts 'creating User'
u1= User.create(email: 'gturcat@me.com', password: "123456")

Booking.destroy_all
puts 'destroy all bookings'
puts 'creating bookings'
b1 = Booking.create(user: User.last, desk: Desk.first, start_date: "01/09/2019", end_date:"05/09/2019" )
b2 = Booking.create(user: User.last, desk: Desk.last, start_date: "05/09/2019", end_date:"10/09/2019" )

