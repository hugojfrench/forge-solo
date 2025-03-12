class FeedbacksController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.post = @post
    @feedback.user = current_user
    if @feedback.save
      redirect_to @post
    else
      render "posts/show"
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:date)
  end
end
