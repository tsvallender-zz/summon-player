class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render root_url
    else
      render 'new'
    end
  end

	private
    def tag_params
      params.require(:tag).permit(:name, :description)
    end
end
