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
    end

    def update
    end

    def destroy
    end

    private
        def ad_params
            params.require(:ad).permit(:title, :text, :category)
        end
end
