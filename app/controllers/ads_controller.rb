class AdsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :archive, :unarchive]
    before_action :set_ad, only: [:show, :edit, :update, :destroy, :archive, :unarchive, :messages, :ad_owner]
    before_action :ad_owner, only: [:edit, :update, :archive, :unarchive]
    require 'will_paginate/array'

    def index
        if params[:ad]
            if ad_params[:category_id].present?
                @ads = Ad.where(category_id: ad_params[:category_id])
            else
                @ads = Ad.all
            end
            unless ad_params[:terms].strip.empty?
                # Search title and text
                @ads = @ads.active.search(ad_params[:terms])

                # Get ads tagged with any terms
                ad_params[:terms].split.each do |t|
                    if tag = Tag.find_by(name: t)
                        @ads += tag.ads.all
                    end
                end
            end
        else
            @ads = Ad.desc.active
        end
        @ads = @ads.paginate(page: params[:page])
    end

    def show
        @message = Message.new
        if (user_signed_in?)
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
        @ad = current_user.ads.build(title: ad_params[:title], content: ad_params[:content])
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
    end

    def update
        if @ad.update(ad_params)
            flash[:success] = "Ad updated"
            redirect_to @ad
        else
            render 'edit'
        end
    end

    def destroy
        @ad.destroy
        flash[:success] = "Ad deleted"
        redirect_to ads_url
    end

    def archive
        @ad.archived = true
        @ad.save!
        flash[:success] = "Ad has been archived"
        redirect_to @ad
    end

    def unarchive
        @ad.archived = false
        @ad.save!
        flash[:success] = "Ad has been unarchived"
        redirect_to @ad
    end

    def messages
        @user = User.find_by(username: params[:user])
        @messages = @ad.conversation(@user)
        @message = Message.new
        render(partial: 'messages')
    end

    private
        def ad_params
            params.require(:ad).permit(:title, :content, :category_id, :taglist, :terms)
        end

        def ad_owner
            redirect_to(root_path) unless current_user == @ad.user
        end

        def set_ad
            @ad = Ad.find(params[:id])
        end
end
