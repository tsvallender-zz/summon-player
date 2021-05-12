class AdsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :archive, :unarchive]
    before_action :ad_owner, only: [:edit, :update, :archive, :unarchive]

    def index
        if params[:ad] && ad_params[:category_id].present? # Filtering by category
            @ads = Ad.desc.active.where(category_id: ad_params[:category_id]).paginate(page: params[:page])
        else
            @ads = Ad.desc.active.paginate(page: params[:page])
        end
    end

    def show
        @message = Message.new
        @ad = Ad.find(params[:id])
        if (user_signed_in?)
            @chat = current_user.chats.where(subject_type: "Ad", subject_id: @ad.id).first
            if @ad.user == current_user
                @chats = @ad.chats
            end
            if @ad.archived && @ad.user != current_user
                flash[:alert] = "You don't have permission to view that ad"
                redirect_to ads_path
            end
        end
    end

    def new
        @ad = Ad.new
    end

    def create
        @ad = current_user.ads.build(title: ad_params[:title], text: ad_params[:text])
        @ad.category = Category.find(ad_params[:category_id])
        if @ad.save
            @ad.addTags(ad_params[:taglist].split(' '))
            flash[:success] = "Ad posted!"
            redirect_to @ad
        else
            render 'new'
        end
    end

    def edit
        @ad = Ad.find(params[:id])
    end

    def update
        ad = Ad.find(params[:id])
        if ad.update(ad_params)
            flash[:success] = "Ad updated"
            redirect_to ad
        else
            render 'edit'
        end
    end

    def destroy
        Ad.find(params[:id]).destroy
        flash[:success] = "Ad deleted"
        redirect_to ads_url
    end

    def archive
        @ad = Ad.find(params[:id])
        @ad.archived = true
        @ad.save!
        flash[:success] = "Ad has been archived"
        redirect_to @ad
    end

    def unarchive
        @ad = Ad.find(params[:id])
        @ad.archived = false
        @ad.save!
        flash[:success] = "Ad has been unarchived"
        redirect_to @ad
    end

    def messages
        @user = User.find_by(username: params[:user])
        @ad = Ad.find(params[:id])
        @messages = @ad.conversation(@user)
        @message = Message.new
        render(partial: 'messages')
    end

    private
        def ad_params
            params.require(:ad).permit(:title, :text, :category_id, :taglist)
        end

        def ad_owner
            @ad = Ad.find(params[:id])
            redirect_to(root_path) unless current_user == @ad.user
        end
end
