# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Destroy existing data
User.destroy_all
Idea.destroy_all
Post.destroy_all
Feedback.destroy_all
Reply.destroy_all

# Create Users
users = User.create!([
  { id: "1", first_name: "Alice", last_name:"coder", email: "alice@example.com", password: "password" },
  { id: "2", first_name: "Bob", last_name: "peters", email: "bob@example.com", password: "password" }
])

puts "Created #{User.count} users"
# Create Ideas for each user
users.each do |user|
    Idea.create!([
      {
      id: "1",
      title: "",
      tagline: "",
      summary: "",
      section_1: "",
      section_2: "",
      section_3: "",
      user: user },

      {
        id: "2",
        title: "",
        tagline: "",
        summary: "",
        section_1: "",
        section_2: "",
        section_3: "",
        user: user },

        {
          id: "3",
          title: "",
          tagline: "",
          summary: "",
          section_1: "",
          section_2: "",
          section_3: "",
          user: user },



    ])
  end
end
