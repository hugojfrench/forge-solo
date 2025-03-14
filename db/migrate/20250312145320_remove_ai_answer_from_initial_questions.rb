class RemoveAiAnswerFromInitialQuestions < ActiveRecord::Migration[7.2]
  def change
    remove_column :initial_questions, :ai_answer, :text
  end
end
