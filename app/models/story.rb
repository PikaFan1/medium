require "babosa"

class Story < ApplicationRecord
  include AASM
  aasm column: 'status', no_direct_assignment: true do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  extend FriendlyId
  friendly_id :slug_options, use: :slugged

  
  # def destroy
  #   update(deleted_at: Time.now)
  # end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  
  ###
  acts_as_paranoid
  
  belongs_to :user
  has_one :pending_story, dependent: :destroy
  has_one_attached :cover_image
  has_many :comments

  validates :title, :content, presence: true

  # default_scope { where(deleted_at: nil )}
  scope :published_stories, -> {published.with_attached_cover_image.order(created_at: :desc).includes(:user)}

  
  private
  def slug_options
    [
      :title,
      [:title, SecureRandom.hex[0,8]]
    ]
  end

end
