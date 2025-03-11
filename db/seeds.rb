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
  { name: "Alice", email: "alice@example.com", password: "password" },
  { name: "Bob", email: "bob@example.com", password: "password" }
])

puts "Created #{User.count} users"
