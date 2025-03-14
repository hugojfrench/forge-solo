class IdeasController < ApplicationController
  before_action :set_idea, only: %i[edit update]

  def index
    @ideas = current_user.ideas
  end

  def edit
    # use last section to add a css class for rounded corners
    @last_section = @idea.sections.last
  end

  def create
    @idea = Idea.new(idea_params)  # have to set the params of title, tagline, and summary here
    @idea.user = current_user
    if @idea.save
      redirect_to edit_idea_path(@idea)  #redirect to the idea edit page
    else
      render :index, status: :unprocessable_entity
    end
  end


  def update
    @idea.update(idea_params)
    @idea.user.initial_questions.destroy_all
  end

  private

  def set_idea
    @idea = Idea.find_by_id(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :tagline, :summary, idea_sections_attributes: %i[id heading content])
  end
end
