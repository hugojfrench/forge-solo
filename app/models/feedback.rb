class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :replies, -> { order(upvotes: :desc) }, dependent: :destroy

  after_create_commit :broadcast_feedback

  private

  def broadcast_feedback
    broadcast_prepend_to "post_#{post.id}_feedbacks",
                        partial: "feedbacks/feedback",
                        target: "feedbacks",
                        locals: { feedback: self, user: self.user }
  end
end
