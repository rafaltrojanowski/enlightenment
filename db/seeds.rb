# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Administrator.count == 0
  a = Administrator.first_or_create! do |a|
    a.email = Configurable[:email]
    a.password = 'q1w2e3$'
    a.first_name = 'Admin'
    a.last_name = 'Prograils'
  end
end
