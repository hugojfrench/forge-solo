class InitialQuestion < ApplicationRecord
  belongs_to :user
  validates :user_question, presence: true


  def content
    client = OpenAI::Client.new
    initial_chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: refreshed_question # pass the results array here - previous -> [{ role: "user", content: self.user_question }]
    })
    new_content = initial_chatgpt_response["choices"][0]["message"]["content"]

    array_new_content = new_content.split("\n\n")

    update(ai_answer1: array_new_content[1])
    update(ai_answer2: array_new_content[2])
    update(ai_answer3: array_new_content[3])

    return self

  end

  private


  def refreshed_question
    initial_questions = user.initial_questions
    results = []
    results << { role: "system", content: "You are an assistant for an idea generator platform." }
    initial_questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: self.ai_answer1 || "" }
      results << { role: "assistant", content: self.ai_answer2 || "" }
      results << { role: "assistant", content: self.ai_answer3 || "" }  # ai_answer 1,2,3
    end
    return results
  end

end
