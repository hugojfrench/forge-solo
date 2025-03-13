class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @feedback = Feedback.new # This is for the form on the show page
    @reply = Reply.new # This is for the form on the show page
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    # This is the part where we save the post to the database
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :tagline, :summary)
  end
end
