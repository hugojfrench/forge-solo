class AddAiAnswer3ToInitialQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :initial_questions, :ai_answer3, :text
  end
end
