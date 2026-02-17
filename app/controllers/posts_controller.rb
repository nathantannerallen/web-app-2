class PostsController < ApplicationController

  def index
    # find all Post rows
    @posts = Post.all
    # render posts/index view
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to("/posts")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:author, :body, :image)
  end
end
