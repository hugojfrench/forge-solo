class AddColumnsToInitialQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :initial_questions, :title1, :string
    add_column :initial_questions, :title2, :string
    add_column :initial_questions, :title3, :string
    add_column :initial_questions, :tagline1, :string
    add_column :initial_questions, :tagline2, :string
    add_column :initial_questions, :tagline3, :string
    add_column :initial_questions, :summary1, :text
    add_column :initial_questions, :summary2, :text
    add_column :initial_questions, :summary3, :text
  end
end
