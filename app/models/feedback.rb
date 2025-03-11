class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :replies, dependent: :destroy
end
