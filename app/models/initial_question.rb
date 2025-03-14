class InitialQuestion < ApplicationRecord
  belongs_to :user
  validates :user_question, presence: true
  after_create :content


  def content
    puts "in content method"
    client = OpenAI::Client.new
    initial_chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: refreshed_question # pass the results array here - previous -> [{ role: "user", content: self.user_question }]
    })
    new_content = initial_chatgpt_response["choices"][0]["message"]["content"]
    p new_content
    array_new_content = new_content.split("###").reject { |c| c == "" }  #split the new content into an array and remove empty strings

    update(title1: array_new_content[0])
    update(tagline1: array_new_content[1])
    update(summary1: array_new_content[2])
    update(title2: array_new_content[3])
    update(tagline2: array_new_content[4])
    update(summary2: array_new_content[5])
    update(title3: array_new_content[6])
    update(tagline3: array_new_content[7])
    update(summary3: array_new_content[8])

    #set title tagline summary for each generated idea 1-3

    return self

  end

  private


  def refreshed_question
    initial_questions = user.initial_questions
    p initial_questions
    results = []
    results << { role: "system", content: "You are an assistant for an idea generator platform. Generate exactly three ideas. For each idea, output a 2 word ### title, a ### tagline, and a two-sentence ### summary. Separate the title, tagline, and summary for each section using ### (three hash symbols) with no extra text or labels. Only include the content in your output. Make sure to seperate each section by ###" }
    initial_questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: self.title1 || "" }
      results << { role: "assistant", content: self.tagline1 || "" }
      results << { role: "assistant", content: self.summary1 || "" }
      results << { role: "assistant", content: self.title2 || "" }
      results << { role: "assistant", content: self.tagline2 || "" }
      results << { role: "assistant", content: self.summary2 || "" }
      results << { role: "assistant", content: self.title3 || "" }
      results << { role: "assistant", content: self.tagline3 || "" }
      results << { role: "assistant", content: self.summary3 || "" }    # ai_answers 1,2,3
    end
    return results
  end

end
