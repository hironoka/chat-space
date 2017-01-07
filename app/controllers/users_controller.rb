class UsersController < ApplicationController

  def index
    @users = User.list_user(params[:name], current_user)
  end

end
