class AdsController < ApplicationController
    def index
        @ads = Ad.paginate(page: params[:page])
    end

    def show
        @ad = Ad.find(params[:id])
    end
end
