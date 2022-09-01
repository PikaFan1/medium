class AddSlugToPendingStory < ActiveRecord::Migration[7.0]
  def change
    add_column :pending_stories, :slug, :string
    add_index :pending_stories, :slug, unique: true
  end
end
