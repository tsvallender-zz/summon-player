class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @tag = Tag.find_by(name: params[:id])
    @ads = @tag.ads.active.paginate(page: params[:page])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to @tag
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find_by(name: params[:id])
  end

  def update
    @tag = Tag.find_by(name: params[:id])
    if @tag.update(tag_params)
      redirect_to @tag
    else
      render 'edit'
    end
  end

  def destroy
    Tag.find_by(name: params[:id]).destroy
    redirect_to tags_path
  end


	private
    def tag_params
      params.require(:tag).permit(:name, :description)
    end
end
