class MessagesController < ApplicationController

   before_action :set_group

  def index
    @groups = Group.all
    @users = @group.users
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

end
