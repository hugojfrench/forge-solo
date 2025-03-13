class IdeasController < ApplicationController
  before_action :set_idea, only: %i[edit update]

  def index
    @ideas = current_user.ideas
  end

  def edit
    # use last section to add a css class for rounded corners
    @last_section = @idea.sections.last
  end

  def update
    @idea.update(idea_params)
  end

  private

  def set_idea
    @idea = Idea.find_by_id(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :tagline, :summary, idea_sections_attributes: %i[id heading content])
  end
end
