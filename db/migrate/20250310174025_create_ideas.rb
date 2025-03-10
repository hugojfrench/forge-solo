class CreateIdeas < ActiveRecord::Migration[7.2]
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :tagline
      t.text :summary
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
