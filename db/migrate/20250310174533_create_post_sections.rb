class CreatePostSections < ActiveRecord::Migration[7.2]
  def change
    create_table :post_sections do |t|
      t.string :heading
      t.text :content
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
