class StoriesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :find_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = current_user.stories.order(updated_at: :desc)
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
    @story.status = 'published' if params[:publish]

    if @story.save
      if params[:publish]
        redirect_to stories_path, notice: '發布成功'
      else
        redirect_to edit_story_path(@story), notice: '儲存成功'
      end
    else
      render :new
    end
  end

  def show
  end 

  def edit
  end

  def update
    @story.status = 'published' if params[:publish]

    if @story.update(story_params)
      if params[:publish]
        redirect_to stories_path, notice: '發布成功'
      else
        redirect_to edit_story_path(@story), notice: '儲存成功'
      end
    else
      render :edit
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_path, notice: '刪除成功！'
  end

  private
  def find_story
    @story = current_user.stories.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :content)
  end
end
