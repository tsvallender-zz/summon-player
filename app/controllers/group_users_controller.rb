class GroupUsersController < ApplicationController
    before_action :authenticate_user!
    def create
        gu = GroupUser.new(groupusers_params)
        if gu.group.privacy == 'open'
            gu.confirmed = true
            if gu.save
                redirect_to gu.group
            end
        elsif gu.group.privacy == 'request'
            gu.save
            redirect_to gu.group
            # todo join list - status in group user
        else
            flash[:error] = "This group is invite-only"
            redirect_to gu.group
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

    def update
        gu = GroupUser.find(params[:id])
        if gu.update(groupusers_params)
            flash[:success] = "Membership confirmed"
            redirect_to requests_group_path(gu.group)
        end
    end

    private
    def groupusers_params
        params.require(:group_user).permit(:group_id, :user_id, :confirmed)
    end
end
