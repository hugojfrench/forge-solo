class Post < ApplicationRecord
  belongs_to :idea
  has_many :feedbacks, dependent: :destroy
  has_many :post_sections, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :post_sections, allow_destroy: true
  has_one_attached :image
end
