class CommentsController < ApplicationController

  before_action :find_discussion, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.discussion = @discussion

    respond_to do |format|
      if @comment.save
        DiscussionMailer.notify_discussion_owner(@comment).deliver_later
        format.html { redirect_to project_discussion_path(@discussion.project, @discussion) }
        format.js { render }
      else
        format.html { render "/discussions/show" }
        format.js { render }
      end
    end
  end

  def edit
    @discussion = @comment.discussion
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to project_discussion_path(@discussion.project, @discussion) }
        format.js { render }
      else
        render :edit
      end
    end
  end

  def destroy
    respond_to do |format|
      @comment.destroy
      format.html { redirect_to project_discussion_path(@discussion.project, @discussion) }
      format.js { render }
    end
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
