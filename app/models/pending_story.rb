require "babosa"

class PendingStory < ApplicationRecord

  belongs_to :story

  extend FriendlyId
  friendly_id :slug_options, use: :slugged

  private
  def slug_options
    [
      :title,
      [:title, SecureRandom.hex[0,8]]
    ]
  end
end
