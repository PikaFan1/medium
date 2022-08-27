class Story < ApplicationRecord
  belongs_to :user

  validates :title, :content, presence: true

  default_scope { where(deleted_at: nil )}

  def destroy
    update(deleted_at: Time.now)
  end
end
