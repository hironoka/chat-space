class GroupsController < ApplicationController

  before_action :set_group, pnly: [:edit, :update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to :root
    else
      render new_group_path
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to :root
    else
      render edit_group_path
    end
  end

  private

  def group_params
    params.require(:group).permit(
    :name,
    user_ids: []
    )
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
