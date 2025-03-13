class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @feedback = Feedback.new # This is for the form on the show page
    @reply = Reply.new # This is for the form on the show page
  end

  def upvote
    @post = Post.find(params[:id])
    @post.increment!(:upvotes)
    render json: { upvotes: @post.upvotes }
  end
end
