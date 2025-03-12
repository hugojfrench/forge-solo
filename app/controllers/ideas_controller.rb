class IdeasController < ApplicationController
  def index
    @ideas = current_user.ideas
  end

  def edit
    @idea = Idea.find_by_id(params[:id])
  end
end
