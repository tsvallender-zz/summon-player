class StaticPagesController < ApplicationController
  def home
    @ads = Ad.order(created_at: :desc).take(5)
  end
end
