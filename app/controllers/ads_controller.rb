class AdsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :ad_owner, only: [:edit, :update]

    def index
        @ads = Ad.paginate(page: params[:page])
    end

    def show
        @ad = Ad.find(params[:id])
    end

    def new
        @ad = Ad.new
    end

    def create
        puts ad_params
        @ad = current_user.ads.build(ad_params)
        if @ad.save
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
        @ad = Ad.find(params[:id])
        if @ad.update(ad_params)
            flash[:success] = "Ad updated"
            redirect_to @ad
        else
            render 'edit'
        end
    end

    def destroy
        Ad.find(params[:id]).destroy
        flash[:success] = "Ad deleted"
        redirect_to ads_url
    end

    private
        def ad_params
            params.require(:ad).permit(:title, :text, :category_id)
        end

        def ad_owner
            @ad = Ad.find(params[:id])
            redirect_to(root_path) unless current_user == @ad.user
        end
end
