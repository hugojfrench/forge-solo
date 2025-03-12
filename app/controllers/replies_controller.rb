class RepliesController < ApplicationController
  def create
    @feedback = Feedback.find(params[:feedback_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.feedback = @feedback
    @feedback.user = current_user
    if @feedback.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to feedback_path(@feedback) }
      end
    else
      render "feedbacks/show", status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content, :user)
  end
end
