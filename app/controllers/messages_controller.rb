class MessagesController < ApplicationController

   before_action :set_group

  def index
    @messages = @group.messages
    @message = Message.new
    @groups = current_user.groups
  end

  def create
    @message = Message.new(message_params)
    @messages = @group.messages
    if @message.save
      redirect_to group_messages_path(@group)
    else
      @message.errors.full_messages.each do |message|
        flash.now[:alert] = message
      end
      render :index
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
    :user_id,
    :group_id
    )
  end
end
