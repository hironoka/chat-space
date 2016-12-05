class MessagesController < ApplicationController

   before_action :set_group

  def index
    @groups = current_user.groups
    @users = @group.users
    @messages = @group.messages
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to :back
    else
      redirect_to :back, alert: "メッセージを入力してください"
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
