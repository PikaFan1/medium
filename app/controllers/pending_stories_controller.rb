class PendingStoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @pending_story = PendingStory.find_by_story_id(params[:id])
    @story = @pending_story.story
  end

  def edit
    @pending_story = PendingStory.find_by_story_id(params[:id])
  end

  def update
    @pending_story = PendingStory.find(params[:id])
    @story = @pending_story.story

    if @pending_story.update(pending_story_params)
      if params[:publish]
        @story.update(title: @pending_story.title, content: @pending_story.content)
        @pending_story.destroy
        redirect_to stories_path, notice: '發布成功'
      else
        redirect_to edit_pending_story_path(@story), notice: '儲存成功'
      end
    else
      render :edit
    end
  end

  def destroy
    @pending_story.destroy
    redirect_to stories_path, notice: '刪除成功！'
  end
  
  private
  def find_pending_story
    @pending_story = PendingStory.find_by_story_id(params[:id])
  end

  def pending_story_params
    params.require(:pending_story).permit(:title, :content)
  end

end
