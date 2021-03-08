class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:id])
    @ads = @user.ads.paginate(page: params[:page])
  end
end
