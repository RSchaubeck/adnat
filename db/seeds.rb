# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shift.destroy_all
User.destroy_all
Organisation.destroy_all

test_org = Organisation.create(name: "Duloc Inc.", hourly_rate: 20.75)
test_user = User.create(name: "Lord Farquaad", email: "the_quaadfather@hotmail.com", password: "password", organisation_id: test_org.id)
test_shift = Shift.create(start: DateTime.new(2021, 9, 6, 9), finish: DateTime.new(2021, 9, 6, 18), break_length: 60, user_id: test_user.id)
