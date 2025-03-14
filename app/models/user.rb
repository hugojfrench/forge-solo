class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ideas
  has_many :posts, through: :ideas
  has_many :feedbacks
  has_many :replies
  has_many :initial_questions
  has_many :expanded_questions
  has_one_attached :avatar
end
