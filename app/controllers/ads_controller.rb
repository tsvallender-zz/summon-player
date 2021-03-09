class AdsController < ApplicationController
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
            params.require(:ad).permit(:title, :text, :category)
        end
end
