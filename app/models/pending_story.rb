require "babosa"

class PendingStory < ApplicationRecord
  extend FriendlyId

  belongs_to :story
  has_one_attached :cover_image
  
  friendly_id :slug_options, use: :slugged

  private
  def slug_options
    [
      :title,
      [:title, SecureRandom.hex[0,8]]
    ]
  end
end
