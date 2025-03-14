class InitialQuestionsController < ApplicationController

  def new
  end

  def show
    @initial_question = InitialQuestion.find(params[:id])
  end

  def create
    @initial_questions = current_user.initial_questions # needed in case of validation error
    if initial_question_params[:changes].present?
      text = "I'd like to make some changes to my previous answers, give me 3 new ideas. Changes: #{initial_question_params[:changes]}"
    else
      text = "I am a #{initial_question_params[:i_am_a]}. I am interested in #{initial_question_params[:i_am_interested_in]}. I am seeking inspiration for #{initial_question_params[:seeking_inspiration_for]}. I am interested in the #{initial_question_params[:ideation_framework]} ideation framework. Additional info: #{initial_question_params[:additional_info]}"
    end
    @initial_question = InitialQuestion.new(user_question: text)
    @initial_question.user = current_user
    if @initial_question.save
      redirect_to initial_question_path(@initial_question)  #redirect to the initial questions show page
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def initial_question_params
    params.permit(:i_am_a, :ideation_framework, :i_am_interested_in, :seeking_inspiration_for, :additional_info, :changes)
  end

end
