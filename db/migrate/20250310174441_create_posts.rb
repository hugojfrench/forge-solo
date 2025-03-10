class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :tagline
      t.text :summary
      t.integer :upvotes
      t.references :idea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
