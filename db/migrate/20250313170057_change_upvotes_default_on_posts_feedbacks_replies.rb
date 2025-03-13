class ChangeUpvotesDefaultOnPostsFeedbacksReplies < ActiveRecord::Migration[7.2]
  def change
    change_column_default :posts, :upvotes, from: nil, to: 0
    change_column_default :feedbacks, :upvotes, from: nil, to: 0
    change_column_default :replies, :upvotes, from: nil, to: 0
  end
end
