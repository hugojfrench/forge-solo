class Idea < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :idea_sections, dependent: :destroy
  accepts_nested_attributes_for :idea_sections
  after_create :set_content

  def upvotes
    # the total upvotes of the idea are equal with the upvotes of the posts associated
    posts.reduce(0) { |total, post| total + post.upvotes }
  end

  def sections
    idea_sections.order(:id)
  end

  def set_content
    client = OpenAI::Client.new
    initial_chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "system", content: "You are an assistant for an idea generator platform. Take this idea and expand it into 3 key sections. These sections should allow the user to take their idea and run with it. For each section, output 4 sentences. Seperate each element by ###. Both the section header and content should be seperated by ###. The format should look like, 'Section1 header ### Section1 content ### Section2 header ### Section 2 content ### Section 3 header ### Section 3 content'. Make sure your output follows exactly this structure. Do not include any extra words or phrases." }, { role: "user", content: self.title  + self.tagline + self.summary }]
    })
    new_content = initial_chatgpt_response["choices"][0]["message"]["content"]
    # p new_content
    array_new_content = new_content.split("###").reject { |c| c == "" }  #split the new content into an array and remove empty strings
    # puts "here is the array"
    # p array_new_content
  end

end
# initial idea is broken up into title, tagline, summmary - done
# the initial idea is being sent to the AI with a prompt to "expand" - done
# AI returns the expanded idea seperated into sections - returns the idea with 3 sections but each section is not its own idea_section instance yet
# idea_sections are created and associated with the idea
# both are saved to the database
# user is brought to idea#edit page - yes but the sections are not displayed yet
# destroy all of the previous initial questions
