# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(username: "jason", password_digest: BCrypt::Password.create('jason'))
u2 = User.create(username: "mikoto", password_digest: BCrypt::Password.create('mikoto'))

t1 = Task.create(head: "Water the plants", body: "have not watered in a long time", user: u1)
t2 = Task.create(head: "Buy a new paintbrush", body: "daler-rowney brand preferred", user: u1)
t3 = Task.create(head: "Chew gum", body: "don't worry i'm going overseas soon, i'll do it then", user: u1)
t4 = Task.create(head: "Destroy some bellcurves", body: "guess i'm out of gum", user: u1)
t5 = Task.create(head: "Fire my railgun", body: "only my railgun can shoot it 今すぐ", user: u1)

tg1 = Tag.create(name: "lifestyle", user: u1)
tg2 = Tag.create(name: "fun", user: u1)
tg3 = Tag.create(name: "urgent", user: u1)
tg4 = Tag.create(name: "social", user: u1)

t1.tags << [tg3]
t2.tags << [tg1, tg4]
t4.tags << [tg1, tg2]
t5.tags << [tg1, tg2, tg4]
