class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(stub: params[:id])
    @ads = @category.ads.paginate(page: params[:page])
  end
end
