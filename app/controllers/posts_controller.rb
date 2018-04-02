class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.sort_by { |x| x.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def vote
    @vote = Vote.create(voteable: @post, vote: params[:vote], user: current_user)

    if @vote.valid?
      flash[:notice] = "You successfully cast your vote on #{@post.title}"
    else
      flash[:error] = "You can only vote once!"
    end

    redirect_to :back
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end 
  end

  def edit; end


  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to posts_path
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
