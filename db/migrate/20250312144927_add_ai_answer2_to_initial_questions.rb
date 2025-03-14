class AddAiAnswer2ToInitialQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :initial_questions, :ai_answer2, :text
  end
end
