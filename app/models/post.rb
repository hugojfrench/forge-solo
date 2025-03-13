class Post < ApplicationRecord
  belongs_to :idea
  has_many :feedbacks, -> { order(upvotes: :desc) }, dependent: :destroy
  has_many :post_sections, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
end
