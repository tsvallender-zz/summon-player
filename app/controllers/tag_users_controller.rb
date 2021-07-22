class TagUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag_user, only: [:destroy]
  before_action :owner, only: [:destroy]

  def create
    tu = TagUser.new(tagusers_params)
    tu.user = current_user

    if tu.save!
      redirect_to tu.tag
    else
      flash[:error] = "Unable to follow tag."
      redirect_to tu.tag
    end
  end

  def destroy
    tag = @tu.tag
    if @tu.destroy
      flash[:success] = "You stopped following this tag."
    end
    redirect_to tag
  end

  private
  def tagusers_params
    params.require(:tag_user).permit(:tag_id)
  end

  def set_tag_user
    @tu = TagUser.find(params[:id])
  end

  def owner
    if current_user != @tu.user
      head :unauthorized
    end
  end
end
