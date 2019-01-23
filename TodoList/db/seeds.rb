# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
t1 = Task.create(head: "Water the plants", body: "have not watered in a long time")
t2 = Task.create(head: "Buy a new paintbrush", body: "daler-rowney brand preferred")
t3 = Task.create(head: "Chew gum", body: "don't worry i'm going overseas soon, i'll do it then")
t4 = Task.create(head: "Destroy some bellcurves", body: "guess i'm out of gum")
t5 = Task.create(head: "Fire my railgun", body: "only my railgun can shoot it 今すぐ")

tg1 = Tag.create(name: "lifestyle")
tg2 = Tag.create(name: "fun")
tg3 = Tag.create(name: "urgent")
tg4 = Tag.create(name: "social")

t1.tags << [tg3]
t2.tags << [tg1, tg4]
t4.tags << [tg1, tg2]
t5.tags << [tg1, tg2, tg4]
