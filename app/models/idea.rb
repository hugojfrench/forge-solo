class Idea < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :idea_sections, dependent: :destroy

  def upvotes
    # the total upvotes of the idea are equal with the upvotes of the posts associated
    posts.reduce(0) { |total, post| total + post.upvotes }
  end
end
