class CommentsController < ApplicationController
  before_action :require_user

  def create

    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end

  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, vote: params[:vote], user: current_user)


    if @vote.valid?
      flash[:notice] = "You successfully cast your vote"
    else
      flash[:error] = "You can only vote once!"
    end

    redirect_to :back
  end


  private

  def comment_params
    params.require(:comment).permit!
  end
end