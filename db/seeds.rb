# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
people = [["male", 600, 180], ["male", 592, 190 ], ["male", 558, 170], ["male", 592, 165],
		  ["female", 500, 100], ["female", 550, 150], ["female", 542, 130], ["female", 575, 150]]

people.each do |gender, height, weight|
	Person.create(gender: gender, height: height, weight: weight)
end