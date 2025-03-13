class PostsController < ApplicationController

  def index
    @posts = Post.order(upvotes: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @feedback = Feedback.new # This is for the form on the show page
    @reply = Reply.new # This is for the form on the show page
  end
end
