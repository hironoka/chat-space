class MessagesController < ApplicationController

   before_action :set_group

  def index
    @messages = @group.messages
    @message = Message.new
    @groups = current_user.groups
  end

  def create
    @message = current_user.messages.new(message_params)
    @messages = @group.messages
    if @message.save
      render json: { body: @message.body,
                     time: @message.time,
                     name: @message.user.name }
    else
      render json: { error: @message.errors.full_messages.first }

    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(
    :body,
    :image,
    ).merge(
    group_id: @group.id
    )
  end
end
