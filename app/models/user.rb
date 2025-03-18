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

  # can add a initial question counter to limit the number of initial questions a user can ask. It should increase by 1 in the create method of initial questions. If the counter is greater than 3, the user should be redirected to the ideas index page with a flash message saying they have reached the limit of initial questions.
  # validates :initial_question_counter, numericality: { less_than_or_equal_to: 3 }
end
