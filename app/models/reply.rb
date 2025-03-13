class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :feedback
  after_create_commit :broadcast_reply

  private

  def broadcast_reply
    broadcast_append_to "feedback_#{feedback.id}_replies",
                        partial: "replies/reply",
                        target: "replies-#{feedback.id}",
                        locals: { reply: self }
  end
end
