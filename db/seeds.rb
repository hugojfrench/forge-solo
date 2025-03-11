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
      title: "GreenTech Hub",
      tagline: "Innovating for a Sustainable Future",
      summary: "A platform connecting green tech startups, investors, and eco-conscious consumers to drive sustainability in technology",
      section_1: "Many promising green tech startups struggle to find investors and customers who prioritize sustainability, slowing down innovation.",
      section_2: "GreenTech Hub serves as a marketplace and networking space where green startups showcase their innovations, connect with investors, and gain exposure to sustainability-driven consumers",
      section_3: "With the green technology sector projected to be worth over $74 billion by 2027, GreenTech Hub taps into a rapidly growing market, facilitating impact-driven investments",
      user: user },

      {
        id: "2",
        title: "MindSync",
        tagline: "AI-Powered Mental Health Support",
        summary: "An AI-driven chatbot and self-care platform providing mental wellness exercises, mindfulness techniques, and therapy matching.",
        section_1: "Millions struggle with mental health, but stigma, cost, and accessibility prevent them from seeking professional help",
        section_2: "MindSync offers AI-powered conversational support, personalized wellness plans, and connects users with certified therapists when needed",
        section_3: "The global mental health apps market is expected to surpass $17 billion by 2030, making MindSync a scalable and impactful solution",
        user: user },

        {
          id: "3",
          title: "SkillBridge",
          tagline: "Bridging the Gap Between Learning and Earning",
          summary: "A skill-based learning platform that connects learners with real-world freelance projects to gain hands-on experience",
          section_1: "Many students and professionals struggle to gain practical experience despite having theoretical knowledge, making it hard to land jobs",
          section_2: "SkillBridge partners with businesses to offer micro-internships and real-world projects, allowing learners to apply their skills while earning.",
          section_3: "With the rise of the gig economy and skill-based hiring, SkillBridge targets a $300 billion online learning industry by providing work-integrated learning solutions",
          user: user },



    ])
  end

puts "Created #{Idea.count} ideas"

# Create Posts for each user

puts "Created #{ideas.count} ideas for user #{user.first_name}"

# Create 3-5 Posts per user using ideas as content
ideas.each do |idea|
  rand(3).times do
    Post.create!(
      title: idea.title,
      content: "#{idea.summary}\n\n#{idea.section_1}\n\n#{idea.section_2}\n\n#{idea.section_3}", # Use all idea sections as post content
      user: user
    )
  end
end

puts "Created #{Post.count} posts"

# Select a random post for feedback
post_with_feedback = Post.order("RANDOM()").first

# Create 5 Feedbacks on one of the posts
feedbacks = []
5.times do
  feedbacks << Feedback.create!(
    content: Faker::Lorem.sentence,
    user: users.sample,
    post: post_with_feedback
  )
end

puts "Created #{Feedback.count} feedbacks on post '#{post_with_feedback.title}'"

# Select one feedback for replies
feedback_with_replies = feedbacks.sample

# Create 3 Replies on one of the feedbacks
3.times do
  Reply.create!(
    content: Faker::Lorem.sentence,
    user: users.sample,
    feedback: feedback_with_replies
  )
end

puts "Created #{Reply.count} replies to feedback '#{feedback_with_replies.content}'"
