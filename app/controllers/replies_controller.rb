class RepliesController < ApplicationController
  def create
    @feedback = Feedback.find(params[:feedback_id])
    @reply = Reply.new(reply_params)
    @reply.feedback = @feedback
    @reply.user = current_user
    if @reply.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@feedback.post) }
      end
    else
      render "posts/show", status: :unprocessable_entity
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content, :user)
  end
end
