class GroupUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group_user, only: [:destroy, :update]
    
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
        elsif gu.group.privacy == 'invite' && gu.group.members.include?(current_user)
            gu.save
            redirect_to invite_group_path(gu.group)
        end
    end

    def destroy
        group = @gu.group
        if group.user == current_user
            flash[:error] = "You can't leave a group you own."
        elsif @gu.destroy
            flash[:success] = "You left " + group.name
        end
        redirect_to group
    end

    def update
        if (@gu.group.privacy == 'request' && @gu.group.user != current_user) ||
           (@gu.group.privacy == 'invite' && @gu.user != current_user)
            redirect_to @gu.group
        elsif @gu.update(groupusers_params)
            flash[:success] = "Membership confirmed"
            redirect_to requests_group_path(@gu.group)
        end
    end

    private
    def groupusers_params
        params.require(:group_user).permit(:group_id, :user_id, :confirmed)
    end

    def set_group_user
        @gu = GroupUser.find(params[:id])
    end
end
