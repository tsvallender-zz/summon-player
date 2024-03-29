class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:id])
    @ads = @user.ads.paginate(page: params[:page]).order(created_at: :desc)
    @chat = Chat.new
  end
end
