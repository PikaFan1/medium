module StoriesHelper
  def cover_image(story, size: 250)
    image_tag story.cover_image.variant(resize_to_limit: [size, size]), class: 'cover-image' if story.cover_image.attached?
  end 
end
