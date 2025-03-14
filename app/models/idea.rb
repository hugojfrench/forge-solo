class Idea < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :idea_sections, dependent: :destroy
  accepts_nested_attributes_for :idea_sections
  after_create :set_content
  after_create :destroy_initial_questions

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
    array_new_content = new_content.split("###").reject { |c| c == "" }  #split the new content into an array and remove empty strings
    array_new_content
    add_sections(array_new_content)
  end

  def add_sections(array)
     IdeaSection.create(heading: array[0], content: array[1], idea_id: self.id)
     IdeaSection.create(heading: array[2], content: array[3], idea_id: self.id)
     IdeaSection.create(heading: array[4], content: array[5], idea_id: self.id)
  end

  def destroy_initial_questions      #destroys all previous initial questions
    user.initial_questions.destroy_all
  end
end
