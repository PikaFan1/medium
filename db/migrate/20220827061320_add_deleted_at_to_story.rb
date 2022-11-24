class AddDeletedAtToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :deleted_at, :datetime
    add_index :stories, :deleted_at
  end
end
