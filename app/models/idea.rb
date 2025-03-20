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
      messages: [{ role: "system", content:
         <<~INSTRUCTION.strip

        You are an assistant for an idea generator platform. Take this idea and expand it into 3 key sections. These sections should allow the user to take their idea and run with it. For each section, output 4 sentences.  Your response must be a single JSON object matching this schema:
        {
          "heading1": "string",
          "content1": "string",
          "heading2": "string",
          "content2": "string",
          "heading3": "string",
          "content3": "string",
        }
        Do not include any extra text or delimiters.
        INSTRUCTION

    }, { role: "user", content: self.title  + self.tagline + self.summary }]
    })

    new_content = initial_chatgpt_response["choices"][0]["message"]["content"]

    parsed_content = JSON.parse(new_content)

    add_sections(parsed_content)
  end

  def add_sections(parsed_content)
     IdeaSection.create(heading: parsed_content["heading1"], content: parsed_content["content1"], idea_id: self.id)
     IdeaSection.create(heading: parsed_content["heading2"], content: parsed_content["content2"], idea_id: self.id)
     IdeaSection.create(heading: parsed_content["heading3"], content: parsed_content["content3"], idea_id: self.id)
  end

  def destroy_initial_questions      
    user.initial_questions.destroy_all
  end
end
