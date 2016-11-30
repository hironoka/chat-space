class GroupsController < ApplicationController

  def index
    @groups = Group.all
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
  end

  private

  def group_params
    params.require(:group).permit(
    :name,
    {user_ids: []}
    )
  end

end
