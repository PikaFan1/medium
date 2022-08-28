class Story < ApplicationRecord
  
  belongs_to :user
  has_one :pending_story, dependent: :destroy

  validates :title, :content, presence: true

  default_scope { where(deleted_at: nil )}

  def destroy
    update(deleted_at: Time.now)
  end

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

end
