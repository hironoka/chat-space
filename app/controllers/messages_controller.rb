class MessagesController < ApplicationController

   before_action :set_group, :set_groups, :set_users

  def index
    @messages = @group.messages
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @messages = @group.messages
    if @message.save
      redirect_to :back
    else
      @message.errors.full_messages.each do |message|
        flash[:alert] = message
      end
      render :index
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_groups
    @groups = current_user.groups
  end

  def set_users
    @users = @group.users
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
