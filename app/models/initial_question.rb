class InitialQuestion < ApplicationRecord
  belongs_to :user
  validates :user_question, presence: true
  after_create :content


  def content
    client = OpenAI::Client.new
    initial_chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini", # Use a model that supports Structured Outputs
      messages: refreshed_question,
      response_format: {
        type: "json_schema",
        json_schema: {
          name: "idea_generator_response",
          schema: {
            type: "object",
            properties: {
              title1: { type: "string" },
              tagline1: { type: "string" },
              summary1: { type: "string" },
              title2: { type: "string" },
              tagline2: { type: "string" },
              summary2: { type: "string" },
              title3: { type: "string" },
              tagline3: { type: "string" },
              summary3: { type: "string" }
            },
            required: [
              "title1", "tagline1", "summary1",
              "title2", "tagline2", "summary2",
              "title3", "tagline3", "summary3"
            ],
            additionalProperties: false
          },
          strict: true
        }
      }
    })
    p initial_chatgpt_response
    new_content = initial_chatgpt_response["choices"][0]["message"]["content"]
    parsed_content = JSON.parse(new_content)
    update(title1: parsed_content["title1"])
    update(tagline1: parsed_content["tagline1"])
    update(summary1: parsed_content["summary1"])
    update(title2: parsed_content["title2"])
    update(tagline2: parsed_content["tagline2"])
    update(summary2: parsed_content["summary2"])
    update(title3: parsed_content["title3"])
    update(tagline3: parsed_content["tagline3"])
    update(summary3: parsed_content["summary3"])
    return self
  end

  private

  def refreshed_question
    initial_questions = user.initial_questions
    results = []
    results << { role: "system", content:
    <<~INSTRUCTION.strip

    Generate three distinct ideas for an idea generator website.
    Your response must be a single JSON object matching this schema:
    {
      "title1": "string",
      "tagline1": "string",
      "summary1": "string",
      "title2": "string",
      "tagline2": "string",
      "summary2": "string",
      "title3": "string",
      "tagline3": "string",
      "summary3": "string"
    }
    Do not include any extra text or delimiters.
    INSTRUCTION
}

    initial_questions.each do |question|
      results << { role: "user", content: question.user_question }
      # You can include past assistant responses if needed:
      results << { role: "assistant", content: "Previous idea: #{question.title1}" } if question.title1.present?
      results << { role: "assistant", content: "Previous idea: #{question.title2}" } if question.title2.present?
      results << { role: "assistant", content: "Previous idea: #{question.title3}" } if question.title3.present?
    end

    return results

  end

end
