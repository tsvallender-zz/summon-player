class GroupUsersController < ApplicationController
    before_action :authenticate_user!
    def create
        gu = GroupUser.new(groupusers_params)
        if gu.group.privacy == 'open'
            if gu.save
                redirect_to gu.group
            end
        elsif gu.group.privacy == 'request'
            flash[:success] = "You have requested to join " + gu.group.name
            redirect_to @group
            # todo join list - status in group user
        else
            flash[:error] = "This group is invite-only"
            redirect_to @group
        end
    end

    def destroy
        gu = GroupUser.find(params[:id])
        group = gu.group
        if group.user == current_user
            flash[:error] = "You can't leave a group you own."
        elsif gu.destroy
            flash[:success] = "You left " + group.name
        end
        redirect_to group
    end

    private
    def groupusers_params
        params.require(:group_user).permit(:group_id, :user_id)
    end
end
