class CommentsController < ApplicationController

  before_action :find_discussion, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.discussion = @discussion

    if @comment.save
      DiscussionMailer.notify_discussion_owner(@comment).deliver_later
      redirect_to project_discussion_path(@discussion.project, @discussion)
    else
      render "/discussions/show"
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to project_discussion_path(@discussion.project, @discussion)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to project_discussion_path(@discussion.project, @discussion)
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

end
