class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  before_action :find_project, only: [:index, :create, :edit, :destroy]
  before_action :find_discussion, only: [:show, :edit, :update, :destroy]

  def index
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.project = @project
    @discussion.user = current_user
    if @discussion.save
      redirect_to project_discussions_path(@project)
    else
      render :index
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update    
    if @discussion.update(discussion_params)
      redirect_to project_discussion_path(@discussion.project, @discussion)
    else
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    redirect_to project_discussions_path(@discussion.project)
  end


  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_discussion
    @discussion = Discussion.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end

end
