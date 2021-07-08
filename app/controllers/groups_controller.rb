class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy, :members, :requests, :invite]
  def index
    # need different page params for different sections
    @groups = Group.all.paginate(page: params[:page])
    @ownedgroups = current_user.groups.paginate(page: params[:page])
    @memberships = current_user.memberships.paginate(page: params[:page])
  end

  def show
    if @group.members.include? current_user
      @groupuser = GroupUser.where(user_id: current_user.id, group_id: @group.id).first
    else 
      @groupuser = GroupUser.new
    end
    @post = Post.new
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
  end

  def update
    if @group.update(group_params)
        flash[:success] = "Group updated"
        redirect_to @group
    else
        render 'edit'
    end
  end

  def destroy
    @group.destroy
    flash[:success] = "Group deleted"
    redirect_to groups_url
  end

  def members
    @members = @group.group_users.where("confirmed = true")
      .paginate(page: params[:page])
  end

  def requests
    if @group.privacy == 'request'
      @members = @group.group_users.where("confirmed = false")
        .paginate(page: params[:page])
      render 'members'
    else
      redirect_to @group
    end
  end

  def invite
    # todo filter/search users
    @users = User.where.not(id: GroupUser.where(group_id: @group.id).pluck(:user_id))
    @users = @users.paginate(page: params[:page])
    @gu = GroupUser.new
  end

  private
  def group_params
      params.require(:group).permit(:name, :privacy)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
