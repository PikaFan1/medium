class UserController < ApplicationController
  skip_before_action :verify_authenticity_token

  def follow
    @user = User.find(params[:id])
    if user_signed_in?
      render json: {status: current_user.follow!(@user)}
    else
      render json: {status: 'sign_in_first'}
    end
  end
end
