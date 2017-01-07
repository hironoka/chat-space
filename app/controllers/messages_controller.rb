class MessagesController < ApplicationController

  before_action :set_group, :set_groups, :set_messages

  def index
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)
    @message.save
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_groups
    @groups = current_user.groups
  end

  def set_messages
    @messages = @group.messages.includes(:user)
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: @group.id)
  end
end
