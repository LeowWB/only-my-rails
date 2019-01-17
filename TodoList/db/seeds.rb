# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
t1 = Task.create(head: "Water the plants", body: "have not watered in a long time")
t2 = Task.create(head: "Buy a new paintbrush", body: "daler-rowney brand preferred")
t3 = Task.create(head: "Fire my railgun", body: "only my railgun can shoot it 今すぐ")

Tag.create(name: "lifestyle", task_id: t2.id)
Tag.create(name: "urgent", task_id: t3.id)
Tag.create(name: "lifestyle", task_id: t3.id)