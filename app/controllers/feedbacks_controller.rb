class FeedbacksController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.post = @post
    @feedback.user = current_user
    if @feedback.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@post) }
      end
    else
      render "posts/show", status: :unprocessable_entity
    end
  end

  def upvote
    @feedback = Feedback.find(params[:id])
    @feedback.increment!(:upvotes)
    render json: { upvotes: @feedback.upvotes }
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content, :user)
  end
end
