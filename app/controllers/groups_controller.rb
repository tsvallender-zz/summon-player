class GroupsController < ApplicationController
  def index
    # need different page params for different sections
    @groups = Group.all.paginate(page: params[:page])
    @ownedgroups = current_user.groups.paginate(page: params[:page])
    @memberships = current_user.memberships.paginate(page: params[:page])
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end
end
