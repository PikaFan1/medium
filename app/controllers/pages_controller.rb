class PagesController < ApplicationController

  def index
    @stories = Story.published_stories
  end

  def show
    @story = Story.friendly.find(params[:story_id])
  end

  def user
    @user = User.find_by_username(params[:username])
    @stories = @user.stories
  end
end
