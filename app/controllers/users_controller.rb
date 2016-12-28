class UsersController < ApplicationController

  def index
    @users = User.list_user(params[:name], current_user)
    respond_to do |format|
      format.json { render json: @users }
    end
  end

end
