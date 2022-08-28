class AddFormToPendingStories < ActiveRecord::Migration[7.0]
  def change
    add_column :pending_stories, :title, :string
    add_column :pending_stories, :content, :text
    add_column :pending_stories, :status, :string, default: 'pending'
  end
end
