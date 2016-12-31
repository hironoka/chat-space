class MessagesController < ApplicationController

   before_action :set_group

  def index
    @messages = @group.messages
    @message = Message.new
    @groups = current_user.groups
    respond_to do |format|
      format.html { render :index }
      messages = @messages.map do |message|
      { body: message.body,
        image: message.image.url,
        time: message.time,
        name: message.user.name }
      end
      format.json { render json: messages }
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    @messages = @group.messages
    @groups = current_user.groups
    respond_to do |format|
      if @message.save
        format.html { render :index }
        format.json { render json: {
                       body: @message.body,
                       image: @message.image.url,
                       time: @message.time,
                       name: @message.user.name }}
      else
        format.html { rednder :index }
        format.json { render json: { error: @message.errors.full_messages.first }}
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
    group_id: @group.id
    )
  end
end
