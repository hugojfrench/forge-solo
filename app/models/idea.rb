class Idea < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :idea_sections, dependent: :destroy
end
