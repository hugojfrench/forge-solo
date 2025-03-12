class InitialQuestion < ApplicationRecord
  belongs_to :user
  validates :user_question, presence: true


  def content
    client = OpenAI::Client.new
    initial_chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: self.user_question }]
    })
    new_content = initial_chatgpt_response["choices"][0]["message"]["content"]

    array_new_content = new_content.split('###')

    update(ai_answer1: array_new_content[0])
    update(ai_answer2: array_new_content[1])
    update(ai_answer3: array_new_content[2])

    return self

  end
end
