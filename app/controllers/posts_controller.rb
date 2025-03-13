class PostsController < ApplicationController
  before_action :set_idea, only: [:new, :create]
  
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
    @post = @idea.posts.build(post_params) # associate idea directly
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_idea
    @idea = Idea.find(params[:idea_id])
  end

  def post_params
    params.require(:post).permit(:title, :tagline, :summary)
  end
end
