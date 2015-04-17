class MembersController < ApplicationController

  def create
    @member = Member.new

    @member.user = User.find(params[:member][:user_id])
    @project = Project.find(params[:project_id])
    @member.project = @project
    # byebug
    if @member.save
      redirect_to @project, notice: "Member Added"
    else
      redirect_to @project, alert: "Can't Add Member"
    end
  end

  def destroy

  end

end
