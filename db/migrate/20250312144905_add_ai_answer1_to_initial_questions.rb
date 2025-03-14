class AddAiAnswer1ToInitialQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :initial_questions, :ai_answer1, :text
  end
end
