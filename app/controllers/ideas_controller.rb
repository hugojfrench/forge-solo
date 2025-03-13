class IdeasController < ApplicationController
  def index
    @ideas = current_user.ideas
  end
end
