# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Project.destroy_all
User.destroy_all
Community.destroy_all



20.times do 
    User.create(
        user_name: Faker::Internet.username,
        age: rand(5..100)
    )
end
10.times do 
    Community.create(
        name: Faker::Commerce.department(max: 1)
    )
end
10.times do 

    current_project = Project.create(
        name: Faker::Verb.base,
        description: Faker::Marketing.buzzwords,
        status: "Started",
        user_id: User.all[rand(19)].id
    )
end