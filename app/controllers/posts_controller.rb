class PostsController < ApplicationController
  before_action :set_idea, only: %i[new create]

  def index
    @posts = Post.order(upvotes: :desc)
    @tags = Tag.all

    # filter the @posts based on the tags selected
    tags_id = params[:tags_id]&.reject(&:blank?)
    if tags_id.present?
      # DISTINCT is only required because we don't have validation in the model and we
      # allow duplicate tags on one post
      @posts = Post.joins(:tags)
                   .where(tags: { id: tags_id })
                   .group('posts.id').having('COUNT(DISTINCT tags.id) = ?', tags_id.count)
                   .order(upvotes: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @feedback = Feedback.new # This is for the form on the show page
    @reply = Reply.new # This is for the form on the show page
  end

  def new
    @post = @idea.posts.build(
      title: @idea.title,
      tagline: @idea.tagline,
      summary: @idea.summary
    )
    @idea.idea_sections.each do |idea_section|
      @post.post_sections.build(
        heading: idea_section.heading,
        content: idea_section.content
      )
    end
  end

  def create
    @post = @idea.posts.build(post_params) # associate idea directly
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def upvote
    @post = Post.find(params[:id])
    @post.increment!(:upvotes)
    render json: { upvotes: @post.upvotes }
  end

  private

  def set_idea
    @idea = Idea.find(params[:idea_id])
  end

  def post_params
    params.require(:post).permit(
      :title,
      :tagline,
      :summary,
      :image,
      post_sections_attributes: %i[id heading content _destroy] # add _destroy for later toggling/deletion
    )
  end
end
