class InitialQuestionsController < ApplicationController

  def new
  end

  def show
  end

  def create
    raise
  end

  private

  def initial_question_params
    params.require(:initial_question).permit(:i_am_a, :ideation_framework, :i_am_interested_in, :seeking_inspiration_for, :additional_info)
  end
end
