class PendingStoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @story = current_user.stories.friendly.find(params[:id])
    @pending_story = @story.pending_story
  end

  def edit
    @story = current_user.stories.friendly.find(params[:id])
    @pending_story = @story.pending_story
  end

  def update
    # Rails.logger.info " -- 123"
    @pending_story = PendingStory.friendly.find(params[:id])
    @story = @pending_story.story

    if @pending_story.update(pending_story_params)
      if params[:publish]
        @story.cover_image.attach(@pending_story.cover_image.blob) if @pending_story.cover_image.attached?
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

  def pending_story_params
    params.require(:pending_story).permit(:title, :content, :cover_image)
  end

  def cover_image_params
  end
end
