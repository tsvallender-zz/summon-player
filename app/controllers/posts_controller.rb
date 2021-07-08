class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    if @post.save
      render
    else
      flash[:error] = "Couldn't create new post"
      redirect_to @post.subject
    end
  end

  private
    def post_params
      params.require(:post).permit(:subject_type, :subject_id, :user_id, :content)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
