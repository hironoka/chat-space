class UsersController < ApplicationController

  def index
    @all_users = User.where('name LIKE(?)', "#{params[:name]}%")
    @users = @all_users.where.not(id: current_user.id)
    respond_to do |format|
      format.json { render json: @users }
    end
  end

end
