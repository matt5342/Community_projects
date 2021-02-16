# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
UserProject.destroy_all
UserCommunity.destroy_all
ProjectCommunity.destroy_all
Project.destroy_all
User.destroy_all
Community.destroy_all



20.times do 
    pw = Faker::Internet.password
    User.create(
        user_name: Faker::Internet.username,
        password: pw,
        password_confirmation: pw,
        age: rand(5..100)
    )
end
10.times do 
    Community.create(
        name: Faker::Commerce.department(max: 1)
    )
end
10.times do 
        Project.create(
        name: Faker::Verb.base,
        description: Faker::Marketing.buzzwords,
        status: "Started",
        goal: rand(3..5),
        user_id: User.all[rand(19)].id
    )

end
20.times do
    project = Project.all[rand(9)]
    UserProject.create(
        user_id: User.all[rand(19)].id, 
        project_id: project.id,
    )
end
10.times do
    ProjectCommunity.create(
        community_id: Community.all[rand(9)].id, 
        project_id: Project.all[rand(9)].id
    )
end
5.times do
    UserCommunity.create(
        community_id: Community.all[rand(9)].id, 
        user_id: User.all[rand(19)].id
    )
end