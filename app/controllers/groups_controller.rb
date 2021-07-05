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

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
        flash[:success] = "Group created!"
        redirect_to @group
    else
        render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])
    if group.update(group_params)
        flash[:success] = "Group updated"
        redirect_to group
    else
        render 'edit'
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    flash[:success] = "Group deleted"
    redirect_to groups_url
  end

  private
  def group_params
      params.require(:group).permit(:name, :privacy)
  end
end
