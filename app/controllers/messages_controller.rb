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
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group) }
        format.json { render json: { body: @message.body,
                                     created_at: @message.created_at.strftime("%Y/%m/%d %H:%M:%S"),
                                     name: @message.user.name } }
      end
    else
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group) }
        format.json { render json: { error: @message.errors.full_messages.first } }
      end
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
    user_id: current_user.id,
    group_id: @group.id
    )
  end
end
