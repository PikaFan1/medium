class PagesController < ApplicationController

  def index
    @stories = Story.order(created_at: :desc).includes(:user)
  end

  def show
    @story = Story.friendly.find(params[:story_id])
  end

  def user
    @user = User.find_by_username(params[:username])
    @stories = @user.stories
  end
end
