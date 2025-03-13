class Idea < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :idea_sections, dependent: :destroy
  accepts_nested_attributes_for :idea_sections

  def upvotes
    # the total upvotes of the idea are equal with the upvotes of the posts associated
    posts.reduce(0) { |total, post| total + post.upvotes }
  end

  def sections
    idea_sections.order(:id)
  end
end


def create

end
# initial idea is broken up into title, tagline, summmary - done
# the initial idea is being sent to the AI with a prompt to "expand" - currently on this
# AI returns the expanded idea seperated into sections
# the "expanded" idea is created
# idea instance is created but only has title, tagline, and summary
# idea_sections are created and associated with the idea
# both are saved to the database
# user is brought to idea#edit page
# destroy all of the previous initial questions
