class Post < ApplicationRecord
  belongs_to :idea
  has_many :feedbacks, -> { order(upvotes: :desc) }, dependent: :destroy
  has_many :post_sections, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :post_sections, allow_destroy: true
  has_one_attached :image

  validate :at_least_one_tag

  private

  def at_least_one_tag
    errors.add(:base, "Post must have at least one tag") if tags.blank?
  end
end
