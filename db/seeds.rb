# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning up the database"
Tag.destroy_all
PostTag.destroy_all
Reply.destroy_all
Feedback.destroy_all
Post.destroy_all
Idea.destroy_all
InitialQuestion.destroy_all
User.destroy_all

# Creating Users
users = []
users << User.create!(email: "john.doe@example.com", password: "password", first_name: "John", last_name: "Doe")
users << User.create!(email: "jane.smith@example.com", password: "password", first_name: "Jane", last_name: "Smith")
users << User.create!(email: "michael.johnson@example.com", password: "password", first_name: "Michael", last_name: "Johnson")
users << User.create!(email: "emily.davis@example.com", password: "password", first_name: "Emily", last_name: "Davis")
users << User.create!(email: "david.wilson@example.com", password: "password", first_name: "David", last_name: "Wilson")

puts "#{User.count} users created"

# Creating Ideas
ideas = []
ideas << Idea.create!(title: "Revolutionary AI Assistant", tagline: "AI that understands you", summary: "An advanced AI assistant that learns and adapts to user needs.", user: users.sample)
ideas << Idea.create!(title: "Sustainable Energy Solutions", tagline: "Powering the future sustainably", summary: "Innovative renewable energy solutions for homes and businesses.", user: users.sample)
ideas << Idea.create!(title: "Smart Home Automation", tagline: "Your home, smarter and safer", summary: "A fully integrated smart home automation system.", user: users.sample)
ideas << Idea.create!(title: "Personal Finance Tracker", tagline: "Take control of your finances", summary: "An app that helps users budget and track their expenses efficiently.", user: users.sample)
ideas << Idea.create!(title: "Eco-Friendly Packaging", tagline: "Sustainable packaging for a greener future", summary: "Biodegradable and compostable packaging solutions.", user: users.sample)

puts "#{Idea.count} ideas created"

# Creating Replies
posts = []

# Creating Idea Sections
ideas.each do |i|
  IdeaSection.create!(
    heading: "Key Benefits",
    content: "Here are the main advantages of this idea.",
    idea: i
  )
  IdeaSection.create!(
    heading: "Key Benefits",
    content: "Here are the main advantages of this idea.",
    idea: i
  )
  IdeaSection.create!(
    heading: "Key Benefits",
    content: "Here are the main advantages of this idea.",
    idea: i
  )

  posts << Post.create!(title: "AI Assistant: The Future of Productivity", tagline: "How AI is changing the workplace", summary: "A deep dive into the benefits and applications of AI assistants.", upvotes: rand(10..100), idea: i)
  posts << Post.create!(title: "Renewable Energy: The Next Big Thing", tagline: "Why green energy is the future", summary: "Exploring the latest innovations in sustainable energy.", upvotes: rand(10..100), idea: i)
  posts << Post.create!(title: "Smart Homes: Convenience & Security", tagline: "Why smart homes are the future", summary: "An overview of the benefits and challenges of smart home tech.", upvotes: rand(10..100), idea: i)
  posts << Post.create!(title: "Managing Your Finances: Tips & Tricks", tagline: "Simple ways to save money", summary: "A guide to effective personal finance management.", upvotes: rand(10..100), idea: i)
  posts << Post.create!(title: "Eco-Friendly Packaging: A Necessity", tagline: "Reducing waste for a better world", summary: "How sustainable packaging can help the environment.", upvotes: rand(10..100), idea: i)
  puts "#{Post.count} posts created for one idea."
end

puts "#{IdeaSection.count} sections created."
puts "total posts created: #{Post.count}"

feedbacks = []

# Creating Post Sections
posts.each do |i|
  PostSection.create!(
    heading: "Important Takeaways",
    content: "These are the most important points from this post.",
    post: i
  )
  PostSection.create!(
    heading: "Important Takeaways",
    content: "These are the most important points from this post.",
    post: i
  )
  PostSection.create!(
    heading: "Important Takeaways",
    content: "These are the most important points from this post.",
    post: i
  )

  feedbacks << Feedback.create!(content: "This is an insightful post. I learned a lot!", upvotes: rand(5..30), user: users.sample, post: i)
  feedbacks << Feedback.create!(content: "Great perspective on renewable energy. Very informative!", upvotes: rand(5..30), user: users.sample, post: i)
  feedbacks << Feedback.create!(content: "I love smart home automation! Thanks for the details.", upvotes: rand(5..30), user: users.sample, post: i)
  feedbacks << Feedback.create!(content: "Managing finances can be tough, but this post really helps.", upvotes: rand(5..30), user: users.sample, post: i)
  feedbacks << Feedback.create!(content: "Sustainable packaging is the way forward. Great insights!", upvotes: rand(5..30), user: users.sample, post: i)
end


puts "#{PostSection.count} sections created."
puts "#{Feedback.count} feedbacks created."

500.times do
  Reply.create!(
    content: "I completely agree with this feedback!",
    upvotes: rand(2..15),
    user: users.sample,
    feedback: feedbacks.sample
  )
end

puts "#{Reply.count} replies created and assigned randomly."

# Creating Tags
tags = []
tags << Tag.create!(name: "Technology")
tags << Tag.create!(name: "Sustainability")
tags << Tag.create!(name: "Finance")
tags << Tag.create!(name: "Smart Home")
tags << Tag.create!(name: "Innovation")

# Assigning Tags to Posts
300.times do
  PostTag.create!(
    post: posts.sample,
    tag: tags.sample
  )
end

puts "#{PostTag.count} post tags created and assigned randomly."

puts "Database seeded successfully with realistic data!"
